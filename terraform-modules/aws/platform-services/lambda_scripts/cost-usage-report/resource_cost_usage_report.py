import boto3
import os
import datetime
import json
import awswrangler as wr
import pandas as pd
from botocore.exceptions import ClientError
from concurrent.futures import ThreadPoolExecutor, as_completed
import time

def fetch_cost_data(billing_client, project, environment, program, start_date):
    today = datetime.datetime.utcnow().date()
    str_today = today.strftime("%Y-%m-%d")
    str_start_date = start_date.strftime("%Y-%m-%d")

    max_retries = 5
    retry_delay = 1

    for attempt in range(max_retries):
        try:
            response = billing_client.get_cost_and_usage_with_resources(
                TimePeriod={
                    'Start': str_start_date,
                    'End': str_today,
                },
                Granularity='DAILY',
                Metrics=['UnblendedCost'],
                Filter={
                    "And": [
                        {"Tags": {"Key": "project", "Values": [project]}},
                        {"Tags": {"Key": "environment", "Values": [environment]}},
                        {"Tags": {"Key": "program", "Values": [program]}}
                    ]
                },
                GroupBy=[{'Type': 'DIMENSION', 'Key': 'RESOURCE_ID'}]
            )
            return response['ResultsByTime'], project, environment, program
        except ClientError as e:
            if e.response['Error']['Code'] == 'LimitExceededException':
                if attempt < max_retries - 1:
                    time.sleep(retry_delay)
                    retry_delay *= 2
                else:
                    print(f"Exceeded rate limit, unable to fetch data for project: {project}, environment: {environment}, program: {program}")
                    return None, project, environment, program
            else:
                print(f"Error fetching cost data: {e}")
                raise

def process_cost_data(data, project, environment, program):
    resources = {'Resource': [], 'Cost': [], 'Project': [], 'Environment': [], 'Program': [], 'Date': []}

    for daily_data in data:
        date = daily_data['TimePeriod']['Start']
        for result in daily_data['Groups']:
            group_key = result['Keys']
            resource = group_key[0]
            cost = float(result['Metrics']['UnblendedCost']['Amount'])
            cost = round(cost, 2)

            if cost > 0:
                resources['Resource'].append(resource)
                resources['Cost'].append(cost)
                resources['Project'].append(project)
                resources['Environment'].append(environment)
                resources['Program'].append(program)
                resources['Date'].append(date)

    return pd.DataFrame(resources)

def save_to_s3(df, bucket_name, folder, program):
    today = datetime.datetime.utcnow().strftime("%Y-%m-%d")
    path = f"s3://{bucket_name}/{folder}/{today}/{program}_resource_costusage_report_{today}.csv"

    try:
        if not df.empty:
            wr.s3.to_csv(df, path=path, index=False)
            print(f"Successfully saved report to {path}")
    except Exception as e:
        print(f"Error saving to S3: {e}")

def get_environment_list(ec2_client):
    environments = set()
    try:
        response = ec2_client.describe_tags(
            Filters=[
                {'Name': 'key', 'Values': ['environment']}
            ]
        )
        for tag in response['Tags']:
            environments.add(tag['Value'])
    except ClientError as e:
        print(f"Error fetching environment tags: {e}")
        # Return an empty list if there's an exception, ensuring the return type is always iterable
        return []
    except Exception as e:
        print(f"Unexpected error when fetching environment tags: {e}")
        return []

    return list(environments)  # Ensure it returns a list, not a set

def lambda_handler(event, context):
    billing_client = boto3.client('ce')
    ec2_client = boto3.client('ec2')
    bucket_name = os.getenv('BUCKET_NAME', 'bucket-name')
    folder = "Bi-weekly"
    lookback_days = int(os.environ.get("LOOKBACK_DAYS", 14))  # Default to 14 days if not set

    try:
        programs_map = json.loads(os.environ.get("PROGRAMS_MAP"))
        environment_list = get_environment_list(ec2_client)
        if not environment_list:
            print("No environments fetched, exiting function.")
            return  # Early exit if no environments are available

        print(f"Fetched environments: {environment_list}")

        start_date = datetime.datetime.utcnow().date() - datetime.timedelta(days=lookback_days)

        with ThreadPoolExecutor(max_workers=10) as executor:
            futures = []
            for environment in environment_list:
                for program, projects in programs_map.items():
                    for project in projects:
                        print(f"Fetching data for project: {project}, environment: {environment}, program: {program}")
                        futures.append(executor.submit(fetch_cost_data, billing_client, project, environment, program, start_date))
            
            program_dfs = {program: [] for program in programs_map}

            for future in as_completed(futures):
                try:
                    data, project, environment, program = future.result()
                    if data:
                        df = process_cost_data(data, project, environment, program)
                        program_dfs[program].append(df)
                    else:
                        print(f"No data fetched for project: {project}, environment: {environment}, program: {program}")
                except Exception as e:
                    print(f"Exception while processing future: {e}")

        for program, dfs in program_dfs.items():
            if dfs:
                merged_df = pd.concat(dfs, ignore_index=True)
                save_to_s3(merged_df, bucket_name, folder, program)
            else:
                print(f"No data to save for program: {program}")

    except Exception as e:
        print(f"Error in lambda handler: {e}")
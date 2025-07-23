import boto3
import os
import csv
from io import StringIO
from datetime import datetime
import time

def send_noncompliant_required_tags_report_to_s3(event, context):
    try:
        # Initialize a Config service client
        client = boto3.client('config')

        # Define Config rule name
        config_rule_name = os.environ.get("config_rule_name")

        # Evaluate config rule 
        response = client.start_config_rules_evaluation(
            ConfigRuleNames=[
                config_rule_name,
            ]
        )
        print(f"started evaluation for {config_rule_name}")

        # buffer time before compliance report creation
        time.sleep(180)
        print("3 minute buffer time")

        # Define an initial NextToken as None
        next_token = None

        page_counter = 1  # Initialize page counter

        # Create a list to store all the CSV data
        all_csv_data = []

        # Get the current date in YYYYMMDD format
        current_date = datetime.now().strftime("%Y-%m-%d")

        # Initialize an S3 service client
        s3 = boto3.client('s3')
        # Define the S3 bucket
        bucket_name = os.environ.get("s3_bucket")

        # Define the header
        header = ['Config-Rule', 'Resource-Type', 'ResourceID', 'Compliance Status']

        while True:
            # Define the parameters for get_compliance_details_by_config_rule
            params = {
                'ConfigRuleName': config_rule_name,
                'ComplianceTypes': ['NON_COMPLIANT'],
                'Limit': 100
            }

            if next_token:
                params['NextToken'] = next_token

            response = client.get_compliance_details_by_config_rule(**params)

            # Extract the compliance details
            compliance_details = response['EvaluationResults']

            if not compliance_details:
                break

            # Define the file name
            file_name = f'{config_rule_name}/{current_date}/{os.environ.get("report_name")}_{page_counter}.csv'

            # Create the CSV content
            csv_content = StringIO()
            csv_writer = csv.writer(csv_content)

            # Write rows
            for detail in compliance_details:
                row = [
                    detail['EvaluationResultIdentifier']['EvaluationResultQualifier']['ConfigRuleName'],
                    detail['EvaluationResultIdentifier']['EvaluationResultQualifier']['ResourceType'],
                    detail['EvaluationResultIdentifier']['EvaluationResultQualifier']['ResourceId'],
                    detail['ComplianceType']
                ]
                csv_writer.writerow(row)

            # Add the CSV content to the list
            all_csv_data.append(csv_content.getvalue())

            # Upload the report to S3
            s3.put_object(Bucket=bucket_name, Key=file_name, Body=csv_content.getvalue(), ContentType='text/csv')
            print(f"Compliance report sent to {bucket_name} with filename: {file_name}")

            # Increment page counter
            page_counter += 1

            # If there are more results, set the next_token
            next_token = response.get('NextToken')
            if not next_token:
                break

        # Concatenate all CSV data into a single string
        all_csv_content = "".join(all_csv_data)

        # Define the S3 bucket and file name for the consolidated CSV
        consolidated_csv_file_name = f'{config_rule_name}/{current_date}/{os.environ.get("report_name")}.csv'

        # Add the header to the consolidated CSV content
        all_csv_content = ",".join(header) + "\n" + all_csv_content

        # Write the content to the consolidated CSV
        s3.put_object(Bucket=bucket_name, Key=consolidated_csv_file_name, Body=all_csv_content, ContentType='text/csv')
        print(f"Consolidated CSV report sent to {bucket_name} with filename: {consolidated_csv_file_name}")

        # List all objects in the bucket
        response = s3.list_objects(Bucket=bucket_name)

        # Delete all CSV files except the consolidated one
        for obj in response.get('Contents', []):
            key = obj['Key']
            if key.startswith(f'{config_rule_name}/{current_date}/') and key.endswith('.csv') and key != consolidated_csv_file_name:
                s3.delete_object(Bucket=bucket_name, Key=key)
                print(f"Deleted {key}")

    except Exception as e:
        print(f"Error: {e}")

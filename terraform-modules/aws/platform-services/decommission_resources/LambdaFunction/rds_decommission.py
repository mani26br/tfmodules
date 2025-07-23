#!/usr/bin/env python3
import boto3

from botocore.exceptions import NoCredentialsError, PartialCredentialsError, ClientError
#from shared_utils import initialize_rds_client
TAGS_TO_CHECK = {"org", "project", "Name", "program", "environment", "access-team"}

def get_rds_instances_with_tags(rds_client, key, key_value):
    rds_instance_ids = []
    key_rds_instance_ids = []

    try:
        response = rds_client.describe_db_instances()
        
        for db_instance in response['DBInstances']:
            try:
                tags = rds_client.list_tags_for_resource(ResourceName=db_instance['DBInstanceArn'])['TagList']
                rds_instance_tags = {tag['Key']: tag['Value'] for tag in tags}
            except rds_client.exceptions.DBInstanceNotFoundFault:
                rds_instance_tags = {}
            
            if not TAGS_TO_CHECK.issubset(set(rds_instance_tags.keys())):
                rds_instance_ids.append(db_instance['DBInstanceIdentifier'])
                print(f"RDS instance {db_instance['DBInstanceIdentifier']} is missing one or more required tags")
                
                if key in rds_instance_tags and rds_instance_tags[key] == key_value:
                    key_rds_instance_ids.append(db_instance['DBInstanceIdentifier'])
                    print(f"RDS instance {db_instance['DBInstanceIdentifier']} has '{key}: {key_value}'")

    except Exception as e:
        print(f"An error occurred: {e}")

    return rds_instance_ids, key_rds_instance_ids

def delete_rds_instances(rds_client, rds_instance_ids):
    for rds_instance_id in rds_instance_ids:
        print("Deleting RDS instance:", rds_instance_id)
        try:
            # This will delete the RDS instance along with its associated resources, including the DB instance, snapshots, and parameter groups.
            rds_client.delete_db_instance(DBInstanceIdentifier=rds_instance_id, SkipFinalSnapshot=True)
            print(f"RDS instance {rds_instance_id} deleted successfully.")
        except Exception as e:
            print(f"Error deleting RDS instance {rds_instance_id}: {e}")

def rds_instances(key, key_value):
    rds_client = boto3.client('rds')
    rds_instance_ids_without_tags, key_rds_instance_ids = get_rds_instances_with_tags(rds_client, key, key_value)

    for rds_instance_id in rds_instance_ids_without_tags:
        print("RDS instance without required tags:", rds_instance_id)
    
    for rds_instance_id in key_rds_instance_ids:
        print(f"{key_value} RDS instance with required tags:", rds_instance_id)
    
    # To delete RDS instances without required tags
    # delete_rds_instances(rds_client, rds_instance_ids_without_tags)
    
    # To delete RDS instances with specific tags
    #delete_rds_instances(rds_client, key_rds_instance_ids)
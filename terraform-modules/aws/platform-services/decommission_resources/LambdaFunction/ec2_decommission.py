#!/usr/bin/env python3
import boto3
import logging
import json
from botocore.exceptions import NoCredentialsError, PartialCredentialsError, ClientError


TAGS_TO_CHECK = {"org", "project", "Name", "program", "environment", "access-team"}

def get_instance_tags(instance):
    return {tag['Key']: tag['Value'] for tag in instance.get('Tags', [])}

def get_instances_without_tags(ec2_client, key, key_value):
    instances = []
    key_instances = []
    response = ec2_client.describe_instances()
    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            instance_id = instance["InstanceId"]
            instance_tags = get_instance_tags(instance)  # Assuming get_instance_tags returns a dict of tags

            # Check if any of the required tags are missing and append to instances list if any are missing
            if not TAGS_TO_CHECK.issubset(set(instance_tags.keys())):
                instances.append(instance_id)

            # Check if provided key and value match with any of the instance tags, and append to key_instances if they do
                #if key in instance_tags and instance_tags[key] == key_value:
                if isinstance(key, str) and key in instance_tags and instance_tags[key] == key_value:    
                    key_instances.append(instance_id)
                    print("key_instances", key_instances)
                    

    print("Instances missing one or more required tags:", instances)
    print(f"Instances with '{key}: {key_value}' among those:", key_instances)
    logging.info("Instances missing one or more required tags: %s", instances)
    logging.info("Instances with '%s: %s' among those: %s", key, key_value, key_instances)

    return instances, key_instances

def delete_instances(ec2_client, instance_ids):
    for instance_id in instance_ids:
        print("Deleting instance:", instance_id)
        logging.info("Deleting instance:", instance_id)
        ec2_client.terminate_instances(InstanceIds=[instance_id])  

def instance_ids(key, key_value):
    ec2_client = boto3.client('ec2')
    instances_without_tags, key_instances = get_instances_without_tags(ec2_client, key, key_value)
    for instance_id in instances_without_tags:
        print("Instance without required tags:", instance_id)
    for instance_id in key_instances:
        print(f"{key_value} instance without required tags:", instance_id)
    #to delete all instances with out required tags
    #delete_instances(ec2_client, instances_without_tags)

    #to delete instances based on key& value without required  tags
    #delete_instances(ec2_client, key_instances)
    logging.info("project based instances-Ids: %s", key_instances)

    #logging.info("instances_without_tags", instances_without_tags)
    return instances_without_tags, key_instances
    
def lambda_handler(event, context):
    log_event = event['awslogs']['data']
    # TODO: Decode and unzip the log data
    log_event_decoded = json.loads(log_event)

    for log in log_event_decoded['logEvents']:
        message = log['message']
        if "Deleting instance:" in message:
            instance_id = message.split("Deleting instance:")[1].strip()
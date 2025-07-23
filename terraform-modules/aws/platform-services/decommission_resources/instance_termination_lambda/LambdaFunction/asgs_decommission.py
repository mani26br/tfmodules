#!/usr/bin/env python3
import boto3
import argparse
from botocore.exceptions import NoCredentialsError, PartialCredentialsError, ClientError

TAGS_TO_CHECK = {"org", "project", "Name", "program", "environment", "access-team"}

def get_asgs_with_tags(asg_client, key, key_value):
    asg_names = []
    key_asg_names = []

    try:
        response = asg_client.describe_auto_scaling_groups()
        asgs = response['AutoScalingGroups']

        for asg in asgs:
            try:
                tags = asg_client.describe_tags(Filters=[{'Name': 'auto-scaling-group', 'Values': [asg['AutoScalingGroupName']]}])['Tags']
                asg_tags = {tag['Key']: tag['Value'] for tag in tags}
            except asg_client.exceptions.ResourceContentionFault:
                asg_tags = {}

            if not TAGS_TO_CHECK.issubset(set(asg_tags.keys())):
                asg_names.append(asg['AutoScalingGroupName'])
                print(f"Auto Scaling Group {asg['AutoScalingGroupName']} is missing one or more required tags")

                if key in asg_tags and asg_tags[key] == key_value:
                    key_asg_names.append(asg['AutoScalingGroupName'])
                    print(f"Auto Scaling Group {asg['AutoScalingGroupName']} has '{key}: {key_value}'")

    except Exception as e:
        print(f"An error occurred: {e}")

    return asg_names, key_asg_names

def delete_asg_instances(asg_client, asg_name):
    try:
        # Get instances associated with the Auto Scaling Group
        response = asg_client.describe_auto_scaling_groups(AutoScalingGroupNames=[asg_name])
        instances = response['AutoScalingGroups'][0]['Instances']

        # Terminate each instance
        for instance in instances:
            instance_id = instance['InstanceId']
            asg_client.terminate_instance_in_auto_scaling_group(InstanceId=instance_id, ShouldDecrementDesiredCapacity=True)
            print(f"Terminated instance {instance_id} associated with Auto Scaling Group {asg_name}")

    except Exception as e:
        print(f"Error terminating instances associated with Auto Scaling Group {asg_name}: {e}")

def delete_asg(asg_client, asg_name):
    try:
        # Terminate instances associated with the Auto Scaling Group
        delete_asg_instances(asg_client, asg_name)

        # Delete the Auto Scaling Group
        asg_client.delete_auto_scaling_group(AutoScalingGroupName=asg_name)
        print(f"Auto Scaling Group {asg_name} deleted successfully.")
    except Exception as e:
        print(f"Error deleting Auto Scaling Group {asg_name}: {e}")

def delete_asgs(asg_client, asg_names):
    for asg_name in asg_names:
        print("Deleting Auto Scaling Group:", asg_name)
        delete_asg(asg_client, asg_name)

def asgs(key, key_value):
    asg_client = boto3.client('autoscaling')
    asg_names_without_tags, key_asg_names = get_asgs_with_tags(asg_client, key, key_value)

    for asg_name in asg_names_without_tags:
        print("Auto Scaling Group without required tags:", asg_name)

    for asg_name in key_asg_names:
        print(f"{key_value} Auto Scaling Group with required tags:", asg_name)

    # Uncomment the following line to delete Auto Scaling Groups without required tags
    # delete_asgs(asg_client, asg_names_without_tags)

    # Uncomment the following line to delete Auto Scaling Groups with specific tags
    # delete_asgs(asg_client, key_asg_names)

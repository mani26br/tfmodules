#!/usr/bin/env python3
import boto3
from botocore.exceptions import NoCredentialsError, PartialCredentialsError, ClientError

TAGS_TO_CHECK = {"org", "project", "Name", "program", "environment", "access-team"}

def get_clbs_with_tags(elb_client, key, key_value):
    clb_names = []
    key_clb_names = []

    try:
        response = elb_client.describe_load_balancers()

        for clb in response['LoadBalancerDescriptions']:
            try:
                tags_response = elb_client.describe_tags(LoadBalancerNames=[clb['LoadBalancerName']])
                tags = tags_response['TagDescriptions'][0]['Tags'] if tags_response['TagDescriptions'] else []
                clb_tags = {tag['Key']: tag['Value'] for tag in tags}
            except elb_client.exceptions.LoadBalancerNotFound:
                clb_tags = {}

            if not TAGS_TO_CHECK.issubset(set(clb_tags.keys())):
                clb_names.append(clb['LoadBalancerName'])
                print(f"CLB {clb['LoadBalancerName']} is missing one or more required tags")

                if key in clb_tags and clb_tags[key] == key_value:
                    key_clb_names.append(clb['LoadBalancerName'])
                    print(f"CLB {clb['LoadBalancerName']} has '{key}: {key_value}'")

    except (boto3.exceptions.NoCredentialsError, boto3.exceptions.PartialCredentialsError):
        print("Please ensure AWS credentials are configured properly.")
    except Exception as e:
        print(f"An error occurred: {e}")

    return clb_names, key_clb_names

def detach_resources_from_elb(elb_client, elb_name):
    try:
        # Describe the instances to get associated resources
        print(f"Detaching resources from ELB {elb_name}.")
        instances = elb_client.describe_instance_health(LoadBalancerName=elb_name)['InstanceStates']

        # Extract instance IDs
        instance_ids = [instance['InstanceId'] for instance in instances]

        # Detach instances
        if instance_ids:
            ec2_client = boto3.client('ec2')
            ec2_client.deregister_instances_from_load_balancer(
                LoadBalancerName=elb_name,
                Instances=instance_ids
            )
            print(f"Instances {instance_ids} detached from ELB {elb_name}.")

        print(f"Resources detached from ELB {elb_name}.")
        return True
    except Exception as e:
        print(f"Error detaching resources from ELB {elb_name}: {e}")
        return False

def delete_clbs(elb_client, elb_names_to_delete):
    try:
        for elb_name in elb_names_to_delete:
            print(f"Deleting CLB: {elb_name}")
            detach_resources_from_elb(elb_client, elb_name)

            # Now, delete the ELB
            print(f"Deleting ELB: {elb_name}")
            elb_client.delete_load_balancer(LoadBalancerName=elb_name)
            print(f"ELB {elb_name} deleted successfully.")

        return True
    except Exception as e:
        print(f"Error deleting CLBs: {e}")
        return False

def clbs(key, key_value):
    elb_client = boto3.client('elb')
    clb_names_without_tags, key_clb_names = get_clbs_with_tags(elb_client, key, key_value)

    for clb_name in clb_names_without_tags:
        print("CLB without required tags:", clb_name)

    for clb_name in key_clb_names:
        print(f"{key_value} CLB with required tags:", clb_name)

    # To delete CLBs without required tags
    # delete_clbs(elb_client, clb_names_without_tags)

    # To delete CLBs with specific tags
    delete_clbs(elb_client, key_clb_names)

    return clb_names_without_tags, key_clb_names



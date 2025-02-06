#!/usr/bin/env python3
import boto3
from botocore.exceptions import NoCredentialsError, PartialCredentialsError, ClientError

TAGS_TO_CHECK = {"org", "project", "Name", "program", "environment", "access-team"}

def get_albs_with_tags(elbv2_client, key, key_value):
    alb_arns = []
    key_alb_arns = []

    try:
        response = elbv2_client.describe_load_balancers()

        for alb in response['LoadBalancers']:
            try:
                tags_response = elbv2_client.describe_tags(ResourceArns=[alb['LoadBalancerArn']])
                tags = tags_response['TagDescriptions'][0]['Tags'] if tags_response['TagDescriptions'] else []
                alb_tags = {tag['Key']: tag['Value'] for tag in tags}
            except elbv2_client.exceptions.ResourceNotFoundException:
                alb_tags = {}

            if not TAGS_TO_CHECK.issubset(set(alb_tags.keys())):
                alb_arns.append(alb['LoadBalancerArn'])
                print(f"ALB {alb['LoadBalancerArn']} is missing one or more required tags")

                if key in alb_tags and alb_tags[key] == key_value:
                    key_alb_arns.append(alb['LoadBalancerArn'])
                    print(f"ALB {alb['LoadBalancerArn']} has '{key}: {key_value}'")

    except (boto3.exceptions.NoCredentialsError, boto3.exceptions.PartialCredentialsError):
        print("Please ensure AWS credentials are configured properly.")
    except Exception as e:
        print(f"An error occurred: {e}")

    return alb_arns, key_alb_arns

def detach_resources_from_elb(elbv2_client, elb_arn):
    try:
        # Describe the listeners to get associated resources
        print(f"Detaching resources from ELB {elb_arn}.")
        listeners = elbv2_client.describe_listeners(LoadBalancerArn=elb_arn)['Listeners']
        

        # Extract associated resources from listeners
        instance_ids = []
        vpc_ids = []
        subnet_ids = []
        network_interface_ids = []

        for listener in listeners:
            if 'DefaultActions' in listener:
                for action in listener['DefaultActions']:
                    if 'TargetGroupArn' in action:
                        target_group_arn = action['TargetGroupArn']
                        target_group = elbv2_client.describe_target_groups(TargetGroupArns=[target_group_arn])['TargetGroups'][0]

                        # Extract associated resources from target group
                        instance_ids.extend([target['Id'] for target in target_group.get('Targets', [])])
                        vpc_ids.extend(target_group.get('VpcId', []))
                        subnet_ids.extend(target_group.get('LoadBalancerArns', []))
                        network_interface_ids.extend(target_group.get('LoadBalancerArns', []))

        # Detach instances
        if instance_ids:
            ec2_client = boto3.client('ec2')
            ec2_client.deregister_instances_from_load_balancer(
                LoadBalancerArn=elb_arn,
                Instances=[{'InstanceId': instance_id} for instance_id in instance_ids]
            )
            print(f"Instances {instance_ids} detached from ELB {elb_arn}.")

        # Detach VPCs
        if vpc_ids:
            print(f"VPCs {vpc_ids} detached from ELB {elb_arn}.")
            # Detach VPCs logic here (modify as needed)
            print(f"VPCs {vpc_ids} detached from ELB {elb_arn}.")

        # Detach Subnets
        if subnet_ids:
            print(f"Subnets {subnet_ids} detached from ELB {elb_arn}.")
            # Detach Subnets logic here (modify as needed)
            print(f"Subnets {subnet_ids} detached from ELB {elb_arn}.")

        # Detach Network Interfaces
        if network_interface_ids:
            # Detach Network Interfaces logic here (modify as needed)
            print(f"Network Interfaces {network_interface_ids} detached from ELB {elb_arn}.")

        print(f"Resources detached from ELB {elb_arn}.")
        return True
    except Exception as e:
        print(f"Error detaching resources from ELB {elb_arn}: {e}")
        return False

def delete_albs(elbv2_client, elb_arns_to_delete):
    try:
        for elb_arn in elb_arns_to_delete:
            print(f"Deleting ALB: {elb_arn}")
            detach_resources_from_elb(elbv2_client, elb_arn)

            # Now, delete the ELB
            print(f"Deleting ELB: {elb_arn}")
            elbv2_client.delete_load_balancer(LoadBalancerArn=elb_arn)
            print(f"ELB {elb_arn} deleted successfully.")

        return True
    except Exception as e:
        print(f"Error deleting ELBs: {e}")
        return False

def albs(key, key_value):
    elbv2_client = boto3.client('elbv2')
    alb_arns_without_tags, key_alb_arns = get_albs_with_tags(elbv2_client, key, key_value)

    for alb_arn in alb_arns_without_tags:
        print("ALB without required tags:", alb_arn)

    for alb_arn in key_alb_arns:
        print(f"{key_value} ALB with required tags:", alb_arn)

    # To delete ALBs without required tags
    # delete_albs(elbv2_client, alb_arns_without_tags)

    # To delete ALBs with specific tags
    delete_albs(elbv2_client, key_alb_arns)

    return alb_arns_without_tags, key_alb_arns
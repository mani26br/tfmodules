#!/usr/bin/env python3
import boto3
import logging

from botocore.exceptions import NoCredentialsError, PartialCredentialsError, ClientError

#from shared_utils import initialize_ec2_client
TAGS_TO_CHECK = {"org", "project", "Name", "program", "environment", "access-team"}

def get_elastic_ips(ec2_client):
    try:
        response = ec2_client.describe_addresses()
        return [address['AllocationId'] for address in response.get('Addresses', [])]
    except Exception as e:
        print(f"Error getting Elastic IPs: {e}")
        return []

def get_elastic_ips_with_tags(ec2_client, key, key_value):
    elastic_ips = []
    key_elastic_ips = []
    try:
        elastic_ip_list = get_elastic_ips(ec2_client)
        
        for elastic_ip in elastic_ip_list:
            try:
                response = ec2_client.describe_addresses(AllocationIds=[elastic_ip])
                tags = response['Addresses'][0].get('Tags', [])
                elastic_ip_tags = {tag['Key']: tag['Value'] for tag in tags}
            except Exception as e:
                print(f"Error getting tags for Elastic IP {elastic_ip}: {e}")
                elastic_ip_tags = {}
            
            if not TAGS_TO_CHECK.issubset(set(elastic_ip_tags.keys())):
                elastic_ips.append(elastic_ip)
                print(f"Elastic IP {elastic_ip} is missing one or more required tags")
                
                if key in elastic_ip_tags and elastic_ip_tags[key] == key_value:
                    key_elastic_ips.append(elastic_ip)
                    print(f"Elastic IP {elastic_ip} has '{key}: {key_value}'")
                
    except (NoCredentialsError, PartialCredentialsError):
        print("Please ensure AWS credentials are configured properly.")
    except Exception as e:
        print(f"An error occurred: {e}")

    return elastic_ips, key_elastic_ips

def disassociate_and_delete_associated_resources(ec2_client, allocation_id):
    try:
        response = ec2_client.describe_addresses(AllocationIds=[allocation_id])
        associations = response['Addresses'][0].get('AssociationIds', [])

        for association_id in associations:
            disassociate_associated_resources(ec2_client, association_id)

    except Exception as e:
        print(f"Error disassociating and deleting associated resources for Elastic IP {allocation_id}: {e}")

def disassociate_associated_resources(ec2_client, association_id):
    try:
        response = ec2_client.describe_addresses(AssociationIds=[association_id])
        association = response['Addresses'][0].get('Association', {})
        resource_id = association.get('InstanceId') or association.get('NetworkInterfaceId') or association.get('NatGatewayId')

        if resource_id:
            disassociate_resource(ec2_client, association_id, resource_id)

    except Exception as e:
        print(f"Error disassociating associated resource {association_id}: {e}")

def disassociate_resource(ec2_client, association_id, resource_id):
    try:
        print(f"Disassociating Elastic IP from resource {resource_id}")
        ec2_client.disassociate_address(AssociationId=association_id)

        if 'nat-gateway' in resource_id:
            ec2_client.delete_nat_gateway(NatGatewayId=resource_id)
            print(f"NAT Gateway {resource_id} disassociated and deleted successfully.")
        elif 'eni' in resource_id:
            ec2_client.delete_network_interface(NetworkInterfaceId=resource_id)
            print(f"Network Interface {resource_id} disassociated and deleted successfully.")
        elif 'i-' in resource_id:
            ec2_client.terminate_instances(InstanceIds=[resource_id])
            print(f"EC2 Instance {resource_id} disassociated and terminated successfully.")
        # Add more cases for other resource types if needed

    except Exception as e:
        print(f"Error disassociating resource {resource_id}: {e}")

def delete_elastic_ips(ec2_client, elastic_ips):
    for elastic_ip in elastic_ips:
        try:
            logging.info(f"Attempting to release Elastic IP: {elastic_ip}")

            # Describe the Elastic IP to get associated resources
            response = ec2_client.describe_addresses(AllocationIds=[elastic_ip])
            associations = response['Addresses'][0].get('Association', {})

            # Disassociate Elastic IP from associated resources
            if 'AssociationId' in associations:
                logging.info(f"Disassociating Elastic IP from Association: {associations['AssociationId']}")
                ec2_client.disassociate_address(AssociationId=associations['AssociationId'])

            if 'InstanceId' in associations:
                logging.info(f"Disassociating Elastic IP from Instance: {associations['InstanceId']}")
                # Detach Elastic IP from Instance without terminating it
                ec2_client.detach_network_interface(AttachmentId=associations['InstanceId'], Force=True)

            if 'NetworkInterfaceId' in associations:
                logging.info(f"Disassociating Elastic IP from Network Interface: {associations['NetworkInterfaceId']}")
                ec2_client.disassociate_address(PublicIp=elastic_ip)

            if 'SubnetId' in associations:
                logging.info(f"Disassociating Elastic IP from Subnet: {associations['SubnetId']}")
                # Add logic to disassociate Elastic IP from Subnet
                # ec2_client.modify_network_interface_attribute(NetworkInterfaceId=associations['NetworkInterfaceId'], UnassignPrivateIpAddresses=[associations['PrivateIpAddress']])

            if 'AllocationId' in associations:
                logging.info(f"Disassociating Elastic IP from VPC: {associations['AllocationId']}")
                # Add logic to disassociate Elastic IP from VPC
                # ec2_client.modify_subnet_attribute(SubnetId=associations['SubnetId'], MapPublicIpOnLaunch=False)

            # Release the Elastic IP
            ec2_client.release_address(AllocationId=elastic_ip)
            
            logging.info(f"Elastic IP {elastic_ip} released successfully.")
        except Exception as e:
            logging.error(f"Error releasing Elastic IP {elastic_ip}: {e}")
            print(f"Error releasing Elastic IP {elastic_ip}: {e}")

         
def elastic_ips(key, key_value):
    ec2_client = boto3.client('ec2')
    elastic_ips_without_tags, key_elastic_ips = get_elastic_ips_with_tags(ec2_client, key, key_value)

    for elastic_ip in elastic_ips_without_tags:
        print("Elastic IP without required tags:", elastic_ip)
    
    for elastic_ip in key_elastic_ips:
        print(f"{key_value} Elastic IP with required tags:", elastic_ip)
    
    # To release Elastic IPs without required tags
    #delete_elastic_ips(ec2_client, elastic_ips_without_tags)
    
    # To release Elastic IPs with specific tags
    delete_elastic_ips(ec2_client, key_elastic_ips)

    return elastic_ips_without_tags, key_elastic_ips
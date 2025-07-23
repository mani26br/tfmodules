#!/usr/bin/env python3
import boto3
from botocore.exceptions import NoCredentialsError, PartialCredentialsError, ClientError

#from shared_utils import initialize_ec2_client

TAGS_TO_CHECK = {"org", "project", "Name", "program", "environment", "access-team"}
def get_vpcs_with_tags(ec2_client, key, key_value):
    vpc_ids = []
    key_vpc_ids = []

    try:
        response = ec2_client.describe_vpcs()

        for vpc in response['Vpcs']:
            try:
                tags = ec2_client.describe_tags(Filters=[
                    {'Name': 'resource-id', 'Values': [vpc['VpcId']]}
                ])['Tags']
                vpc_tags = {tag['Key']: tag['Value'] for tag in tags}
            except ec2_client.exceptions.ResourceNotFoundException:
                vpc_tags = {}

            if not TAGS_TO_CHECK.issubset(set(vpc_tags.keys())):
                vpc_ids.append(vpc['VpcId'])
                print(f"VPC {vpc['VpcId']} is missing one or more required tags")

                if key in vpc_tags and vpc_tags[key] == key_value:
                    key_vpc_ids.append(vpc['VpcId'])
                    print(f"VPC {vpc['VpcId']} has '{key}: {key_value}'")

    except Exception as e:
        print(f"An error occurred: {e}")

    return vpc_ids, key_vpc_ids

def delete_vpcs(ec2_client, vpc_ids):
    for vpc_id in vpc_ids:
        print("Deleting VPC:", vpc_id)
        try:
            # First, delete associated resources
            if not delete_associated_resources(ec2_client, vpc_id):
                print(f"Error deleting VPC {vpc_id}: Unable to delete associated resources.")
            else:
                # Then, delete the VPC
                ec2_client.delete_vpc(VpcId=vpc_id)
                print(f"VPC {vpc_id} deleted successfully.")
        except Exception as e:
            print(f"Error deleting VPC {vpc_id}: {e}")

def delete_associated_resources(ec2_client, vpc_id):
    ec2_client = boto3.client('ec2')

    # Step 2: Delete Subnets
    delete_subnets(ec2_client, vpc_id)

    # Step 3: Delete Route Tables
    delete_route_tables(ec2_client, vpc_id)

    # Step 4: Delete Security Groups
    delete_security_groups(ec2_client, vpc_id)

    # Step 5: Delete Network ACLs
    delete_network_acls(ec2_client, vpc_id)

    # Step 6: Delete Internet Gateways
    delete_internet_gateways(ec2_client, vpc_id)

    # Step 7: Delete VPN Connections
    delete_vpn_connections(ec2_client, vpc_id)

    # Step 8: Delete Network Interfaces
    delete_network_interfaces(ec2_client, vpc_id)

    # Step 9: Delete EC2 Instances
    delete_ec2_instances(ec2_client, vpc_id)

    # Step 10: Delete VPC
    delete_vpc(ec2_client, vpc_id)

def delete_subnets(ec2_client, vpc_id):
    try:
        subnets = ec2_client.describe_subnets(Filters=[{'Name': 'vpc-id', 'Values': [vpc_id]}])['Subnets']
        for subnet in subnets:
            subnet_id = subnet['SubnetId']

            # Disassociate network interfaces from the subnet
            network_interfaces = ec2_client.describe_network_interfaces(Filters=[{'Name': 'subnet-id', 'Values': [subnet_id]}])['NetworkInterfaces']
            for network_interface in network_interfaces:
                detach_and_delete_network_interface(ec2_client, network_interface)

            # Disassociate route tables from the subnet
            route_tables = ec2_client.describe_route_tables(Filters=[{'Name': 'association.subnet-id', 'Values': [subnet_id]}])['RouteTables']
            for route_table in route_tables:
                try:
                    association_id = [a['RouteTableAssociationId'] for a in route_table['Associations'] if a['SubnetId'] == subnet_id][0]
                    ec2_client.disassociate_route_table(AssociationId=association_id)
                    print(f"Disassociated Route Table {route_table['RouteTableId']} from Subnet {subnet_id}")
                except Exception as e:
                    print(f"Error disassociating Route Table from Subnet {subnet_id}: {e}")

            # Delete the subnet
            try:
                ec2_client.delete_subnet(SubnetId=subnet_id)
                print(f"Deleted Subnet {subnet_id} associated with VPC {vpc_id}")
            except ec2_client.exceptions.ClientError as e:
                if 'DependencyViolation' in str(e):
                    print(f"Cannot delete Subnet {subnet_id} due to dependencies. Attempting to resolve dependencies.")
                    resolve_subnet_dependencies(ec2_client, subnet_id)
                else:
                    print(f"Error deleting Subnet {subnet_id}: {e}")

    except Exception as e:
        print(f"Error deleting subnets for VPC {vpc_id}: {e}")

def delete_route_tables(ec2_client, vpc_id):
    try:
        route_tables = ec2_client.describe_route_tables(Filters=[{'Name': 'vpc-id', 'Values': [vpc_id]}])['RouteTables']

        for route_table in route_tables:
            # Disassociate subnets from the route table
            for association in route_table.get('Associations', []):
                subnet_id = association.get('SubnetId')
                try:
                    ec2_client.disassociate_route_table(AssociationId=association['RouteTableAssociationId'])
                    print(f"Disassociated subnet {subnet_id} from Route Table {route_table['RouteTableId']}")
                except Exception as e:
                    print(f"Error disassociating subnet {subnet_id} from Route Table {route_table['RouteTableId']}: {e}")

            # Delete the route table
            try:
                ec2_client.delete_route_table(RouteTableId=route_table['RouteTableId'])
                print(f"Deleted Route Table {route_table['RouteTableId']} associated with VPC {vpc_id}")
            except Exception as e:
                print(f"Error deleting Route Table {route_table['RouteTableId']}: {e}")

    except Exception as e:
        print(f"Error deleting route tables for VPC {vpc_id}: {e}")

def delete_security_groups(ec2_client, vpc_id):
    security_groups = ec2_client.describe_security_groups(Filters=[{'Name': 'vpc-id', 'Values': [vpc_id]}])['SecurityGroups']

    for security_group in security_groups:
        security_group_id = security_group['GroupId']

        # Skip deletion of default security groups
        if security_group.get('GroupName') == 'default':
            print(f"Skipping deletion of default security group {security_group_id}")
            continue

        # Delete the security group
        try:
            ec2_client.delete_security_group(GroupId=security_group_id)
            print(f"Deleted Security Group {security_group_id} associated with VPC {vpc_id}")
        except ec2_client.exceptions.ClientError as e:
            if 'DependencyViolation' in str(e):
                print(f"Cannot delete Security Group {security_group_id} due to dependencies.")
            elif 'CannotDelete' in str(e) and 'the specified group' in str(e) and 'cannot be deleted by a user' in str(e):
                print(f"Skipping deletion of security group {security_group_id}: {e}")
            else:
                print(f"Error deleting Security Group {security_group_id}: {e}")


def delete_network_acls(ec2_client, vpc_id):
    network_acls = ec2_client.describe_network_acls(Filters=[{'Name': 'vpc-id', 'Values': [vpc_id]}])['NetworkAcls']

    for network_acl in network_acls:
        network_acl_id = network_acl['NetworkAclId']

        # Skip deletion of default network ACLs
        if network_acl.get('IsDefault', False):
            print(f"Skipping deletion of default network ACL {network_acl_id}")
            continue

        # Delete the network ACL
        try:
            ec2_client.delete_network_acl(NetworkAclId=network_acl_id)
            print(f"Deleted Network ACL {network_acl_id} associated with VPC {vpc_id}")
        except ec2_client.exceptions.ClientError as e:
            if 'DependencyViolation' in str(e):
                print(f"Cannot delete Network ACL {network_acl_id} due to dependencies.")
            elif 'InvalidParameterValue' in str(e) and 'cannot delete default network ACL' in str(e):
                print(f"Skipping deletion of default network ACL {network_acl_id}")
            else:
                print(f"Error deleting Network ACL {network_acl_id}: {e}")


def delete_internet_gateways(ec2_client, vpc_id):
    try:
        internet_gateways = ec2_client.describe_internet_gateways(Filters=[{'Name': 'attachment.vpc-id', 'Values': [vpc_id]}])['InternetGateways']
        for internet_gateway in internet_gateways:
            try:
                ec2_client.detach_internet_gateway(InternetGatewayId=internet_gateway['InternetGatewayId'], VpcId=vpc_id)
                print(f"Detached Internet Gateway {internet_gateway['InternetGatewayId']} from VPC {vpc_id}")
            except ec2_client.exceptions.ClientError as e:
                print(f"Error detaching Internet Gateway {internet_gateway['InternetGatewayId']} from VPC {vpc_id}: {e}")

            try:
                ec2_client.delete_internet_gateway(InternetGatewayId=internet_gateway['InternetGatewayId'])
                print(f"Deleted Internet Gateway {internet_gateway['InternetGatewayId']} associated with VPC {vpc_id}")
            except ec2_client.exceptions.ClientError as e:
                if 'DependencyViolation' in str(e):
                    print(f"Cannot delete Internet Gateway {internet_gateway['InternetGatewayId']} due to dependencies.")
                else:
                    print(f"Error deleting Internet Gateway {internet_gateway['InternetGatewayId']}: {e}")

    except Exception as e:
        print(f"Error deleting internet gateways for VPC {vpc_id}: {e}")

def delete_vpn_connections(ec2_client, vpc_id):
    vpn_connections = ec2_client.describe_vpn_connections()['VpnConnections']

    for vpn_connection in vpn_connections:
        if vpn_connection.get('VpcId') == vpc_id:
            vpn_connection_id = vpn_connection['VpnConnectionId']

            # Delete the VPN connection
            try:
                ec2_client.delete_vpn_connection(VpnConnectionId=vpn_connection_id)
                print(f"Deleted VPN Connection {vpn_connection_id} associated with VPC {vpc_id}")
            except ec2_client.exceptions.ClientError as e:
                print(f"Error deleting VPN Connection {vpn_connection_id}: {e}")



def delete_network_interfaces(ec2_client, vpc_id):
    try:
        network_interfaces = ec2_client.describe_network_interfaces(Filters=[{'Name': 'vpc-id', 'Values': [vpc_id]}])['NetworkInterfaces']
        for network_interface in network_interfaces:
            detach_and_delete_network_interface(ec2_client, network_interface)

    except Exception as e:
        print(f"Error deleting network interfaces for VPC {vpc_id}: {e}")

def delete_ec2_instances(ec2_client, vpc_id):
    try:
        instances = ec2_client.describe_instances(Filters=[{'Name': 'vpc-id', 'Values': [vpc_id]}])['Reservations']
        for reservation in instances:
            for instance in reservation['Instances']:
                instance_id = instance['InstanceId']
                try:
                    ec2_client.terminate_instances(InstanceIds=[instance_id])
                    print(f"Terminated EC2 Instance {instance_id} associated with VPC {vpc_id}")
                except ec2_client.exceptions.ClientError as e:
                    if 'DryRunOperation' not in str(e):
                        print(f"Error terminating EC2 Instance {instance_id}: {e}")

    except Exception as e:
        print(f"Error deleting EC2 instances for VPC {vpc_id}: {e}")

def detach_and_delete_network_interface(ec2_client, network_interface):
    network_interface_id = network_interface['NetworkInterfaceId']

    # Detach the network interface
    try:
        ec2_client.detach_network_interface(AttachmentId=network_interface.get('Attachment', {}).get('AttachmentId'), DryRun=True)
    except ec2_client.exceptions.ClientError as e:
        if 'DryRunOperation' not in str(e):
            print(f"Error during dry run for detaching Network Interface {network_interface_id}: {e}")
            return

    # If the dry run succeeded, detach the network interface
    try:
        ec2_client.detach_network_interface(AttachmentId=network_interface.get('Attachment', {}).get('AttachmentId'), DryRun=False, Force=True)
        print(f"Detached Network Interface {network_interface_id}")
    except Exception as e:
        print(f"Error detaching Network Interface {network_interface_id}: {e}")
        return

    # Delete the network interface
    try:
        ec2_client.delete_network_interface(NetworkInterfaceId=network_interface_id)
        print(f"Deleted Network Interface {network_interface_id}")
    except Exception as e:
        print(f"Error deleting Network Interface {network_interface_id}: {e}")

def resolve_route_table_dependencies(ec2_client, vpc_id):
    try:
        # Describe route tables for the VPC
        route_tables = ec2_client.describe_route_tables(Filters=[{'Name': 'vpc-id', 'Values': [vpc_id]}])['RouteTables']

        for route_table in route_tables:
            route_table_id = route_table['RouteTableId']

            # Disassociate subnets from the route table
            for association in route_table.get('Associations', []):
                subnet_id = association.get('SubnetId')

                # Skip disassociation of the main route table association
                if association.get('Main'):
                    print(f"Skipping disassociation of the main route table association for subnet {subnet_id}")
                    continue

                try:
                    ec2_client.disassociate_route_table(AssociationId=association['RouteTableAssociationId'])
                    print(f"Disassociated subnet {subnet_id} from Route Table {route_table_id}")
                except Exception as e:
                    print(f"Error disassociating subnet {subnet_id} from Route Table {route_table_id}: {e}")

            # Delete the route table
            try:
                ec2_client.delete_route_table(RouteTableId=route_table_id)
                print(f"Deleted Route Table {route_table_id} associated with VPC {vpc_id}")
            except ec2_client.exceptions.ClientError as e:
                if 'DependencyViolation' in str(e):
                    print(f"Cannot delete Route Table {route_table_id} due to dependencies.")
                else:
                    print(f"Error deleting Route Table {route_table_id}: {e}")

    except Exception as e:
        print(f"Error resolving dependencies for VPC {vpc_id}: {e}")

def resolve_subnet_dependencies(ec2_client, subnet_id):
    try:
        # Retrieve and delete resources associated with the subnet
        network_interfaces = ec2_client.describe_network_interfaces(Filters=[{'Name': 'subnet-id', 'Values': [subnet_id]}])['NetworkInterfaces']
        for network_interface in network_interfaces:
            # Detach Elastic IP addresses first (if any)
            for attachment in network_interface.get('Attachment', {}).get('ElasticIp', []):
                try:
                    ec2_client.disassociate_address(AssociationId=attachment['AssociationId'])
                    print(f"Elastic IP {attachment['PublicIp']} disassociated.")
                except Exception as e:
                    print(f"Error disassociating Elastic IP {attachment['PublicIp']}: {e}")

            # Detach and delete the network interface forcefully
            detach_and_delete_network_interface(ec2_client, network_interface)

            # Disassociate route tables from the subnet
            route_tables = ec2_client.describe_route_tables(Filters=[{'Name': 'association.subnet-id', 'Values': [subnet_id]}])['RouteTables']
            for route_table in route_tables:
                try:
                    association_id = [a['RouteTableAssociationId'] for a in route_table['Associations'] if a['SubnetId'] == subnet_id][0]
                    ec2_client.disassociate_route_table(AssociationId=association_id)
                    print(f"Disassociated Route Table {route_table['RouteTableId']} from Subnet {subnet_id}")
                except Exception as e:
                    print(f"Error disassociating Route Table from Subnet {subnet_id}: {e}")

        # Retry deleting the subnet after resolving dependencies
        ec2_client.delete_subnet(SubnetId=subnet_id)
        print(f"Deleted Subnet {subnet_id} after resolving dependencies.")
    except Exception as e:
        print(f"Error resolving dependencies for Subnet {subnet_id}: {e}")

def delete_vpc(ec2_client, vpc_id):
    try:
        ec2_client.delete_vpc(VpcId=vpc_id)
        print(f"Deleted VPC {vpc_id} successfully.")
    except Exception as e:
        print(f"Error deleting VPC {vpc_id}: {e}")

def vpcs(key, key_value):
    ec2_client = boto3.client('ec2')
    vpc_ids_without_tags, key_vpc_ids = get_vpcs_with_tags(ec2_client, key, key_value)

    for vpc_id in vpc_ids_without_tags:
        print("VPC without required tags:", vpc_id)

    for vpc_id in key_vpc_ids:
        print(f"{key_value} VPC with required tags:", vpc_id)

    # To delete VPCs without required tags
    # delete_vpcs(ec2_client, vpc_ids_without_tags)

    # To delete VPCs with specific tags
    delete_vpcs(ec2_client, key_vpc_ids)
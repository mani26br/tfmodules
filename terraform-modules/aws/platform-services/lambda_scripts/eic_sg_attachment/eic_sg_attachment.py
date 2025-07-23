import boto3
import os
import json


def lambda_handler(event, context):
    # Parse environment variables
    security_group_name = os.environ.get("security_group_name")
    region = os.environ.get("region")
    project_values = json.loads(os.environ.get("project_values"))

    # Initialize a session using the specified AWS region
    session = boto3.Session(region_name=region)
    ec2 = session.resource('ec2')
    client = session.client('ec2')

    # Retrieve all subnets and identify private subnets
    private_subnets = set()
    for subnet in ec2.subnets.all():
        route_tables = client.describe_route_tables(
            Filters=[{'Name': 'association.subnet-id', 'Values': [subnet.id]}]
        )
        is_private = True  # Assume subnet is private until proven otherwise
        for route_table in route_tables['RouteTables']:
            for route in route_table['Routes']:
                if route.get('GatewayId', '').startswith('igw-'):  # Public route
                    is_private = False
                    break
            if not is_private:
                break
        if is_private:
            private_subnets.add(subnet.id)

    # A dictionary to cache security group IDs for each VPC
    vpc_sg_map = {}

    # Filter instances based on the project tag values
    filters = [
        {
            'Name': 'tag:project',
            'Values': project_values
        }
    ]

    # Retrieve all EC2 instances that match the filter
    filtered_instances = ec2.instances.filter(Filters=filters)

    # Attach the security group only to instances in private subnets
    for instance in filtered_instances:
        instance_id = instance.id
        instance_vpc_id = instance.vpc_id
        instance_subnet_id = instance.subnet_id

        # Check if the instance is in a private subnet
        if instance_subnet_id not in private_subnets:
            print(f"Instance '{instance_id}' is not in a private subnet. Skipping.")
            continue

        try:
            # Fetch the security group ID for this VPC
            if instance_vpc_id not in vpc_sg_map:
                response = client.describe_security_groups(
                    Filters=[
                        {'Name': 'group-name', 'Values': [security_group_name]},
                        {'Name': 'vpc-id', 'Values': [instance_vpc_id]}
                    ]
                )
                if response['SecurityGroups']:
                    sg_id = response['SecurityGroups'][0]['GroupId']
                    vpc_sg_map[instance_vpc_id] = sg_id
                    print(f"Found Security Group '{security_group_name}' with ID '{sg_id}' in VPC '{instance_vpc_id}'")
                else:
                    print(f"Security Group '{security_group_name}' not found in VPC '{instance_vpc_id}'. Skipping instance '{instance_id}'")
                    continue
            else:
                sg_id = vpc_sg_map[instance_vpc_id]

            # Get current security group IDs and add the new one if not present
            current_sg_ids = [sg['GroupId'] for sg in instance.security_groups]
            if sg_id not in current_sg_ids:
                current_sg_ids.append(sg_id)
                instance.modify_attribute(Groups=current_sg_ids)
                print(f"Attached security group '{sg_id}' to instance '{instance_id}' in private subnet '{instance_subnet_id}'")
            else:
                print(f"Instance '{instance_id}' already has security group '{sg_id}' attached.")

        except Exception as e:
            print(f"Error attaching security group to instance '{instance_id}': {e}")

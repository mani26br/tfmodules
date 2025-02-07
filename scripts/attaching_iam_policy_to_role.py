'''
We need to install boto3 and logging packages before executing script

Note: This Script need to be executed as below
    python3 attaching_iam_policy_to_role.py access_key="aws access key value" secret_key="aws secret key value"
            accountid="Please pass aws account number" region="pass region" 

'''

import sys
import boto3
import logging

ACCESS_KEY = ""
SECRET_ACCESS_KEY = ""

def attach_aws_iam_policy(aws_access_key, aws_secret_key, Role_name=None, policy_name=None):
    iam_client = boto3.client('iam', aws_access_key_id=aws_access_key, aws_secret_access_key=aws_secret_key)
    construct_policy_arn = "arn:aws:iam::aws:policy/"+policy_name
    logging.info(" Policy arn {} that need to attache to role {}".format(construct_policy_arn,Role_name))
    attach_iam_policy = iam_client.attach_role_policy(RoleName=Role_name,PolicyArn=construct_policy_arn)
    return

def attach_custom_iam_policy(aws_access_key, aws_secret_key, Role_name=None, policy_name=None, accnt_id=None):
    iam_client = boto3.client('iam', aws_access_key_id=aws_access_key, aws_secret_access_key=aws_secret_key)
    construct_policy_arn = "arn:aws:iam::"+accnt_id+":policy/"+policy_name
    logging.info(" Policy arn {} that need to attache to role {}".format(construct_policy_arn,Role_name))
    attach_iam_policy = iam_client.attach_role_policy(RoleName=Role_name,PolicyArn=construct_policy_arn)
    return


def iam_instance_role(aws_access_key, aws_secret_key, Instance_profile_name=None, account_id=None):
    iam_client = boto3.client('iam', aws_access_key_id=aws_access_key, aws_secret_access_key=aws_secret_key)
    get_iam_instance_profile = iam_client.get_instance_profile(InstanceProfileName=Instance_profile_name)
    get_iam_role = get_iam_instance_profile['InstanceProfile']['Roles'][0]['RoleName']
    role_name = get_iam_role
    list_of_policies = iam_client.list_attached_role_policies(RoleName=get_iam_role)
    Role_with_max_policies=""
    policy_list = []
    #Please add aws managed policies to below list
    list_of_aws_policies_to_check = ["AmazonSSMManagedInstanceCore"]
    #Please add custom managed policies to below list
    list_of_custom_policies_to_check =["AmazonSSM_S3_Policy"]
    for policys in list_of_policies['AttachedPolicies']:
        policy_list.append(policys['PolicyName'])
    logging.info(" Getting list of policies that are attached to Role "+role_name)
    if len(policy_list) == 10:
        logging.info(" Iam role {} has 10 policies attached ".format(role_name))
        Role_with_max_policies = role_name
        print("Role_with_max_policies", Role_with_max_policies)
        pass
    else:
        for policy in list_of_aws_policies_to_check:
            if policy in policy_list:
                logging.info(" We have required policy {0} to role {1} ".format(policy,role_name))
            else:
                attach_policies = attach_aws_iam_policy(aws_access_key, aws_secret_key, Role_name=role_name, policy_name=policy)
        for policy in list_of_custom_policies_to_check:
            if policy in policy_list:
                logging.info(" We have required policy {0} to role {1} ".format(policy,role_name))
            else:
                attach_policies = attach_custom_iam_policy(aws_access_key, aws_secret_key, Role_name=role_name, policy_name=policy, accnt_id=account_id)
    return Role_with_max_policies


def ec2_details(aws_access_key, aws_secret_key, accountid, region):
    logging.basicConfig(level=logging.INFO)
    ec2_client = boto3.client('ec2', aws_access_key_id=aws_access_key, aws_secret_access_key=aws_secret_key, region_name=region)
    logging.info(" Ec2 client initation")
    ec2_describe = ec2_client.describe_instances(InstanceIds=[])
    list_of_roles_with_max_policies = []
    for ec2_reservations in ec2_describe["Reservations"]:
        logging.info( 30*"*")
        logging.info(" Describe list of ec2 instances")
        for ec2_instance in ec2_reservations["Instances"]:
            Instance_Id = ec2_instance["InstanceId"]
            State = ec2_instance["State"]["Name"]
            logging.info( 30*" ")
            logging.info(" Instance Id is {}".format(Instance_Id))
            
            if 'IamInstanceProfile' in ec2_instance:
                Iam_Instance_profile_arn = ec2_instance['IamInstanceProfile']['Arn']
                get_instance_profile_name = Iam_Instance_profile_arn.split('/')[1]
                logging.info(" Ec2 instance that have iam instance profile "+get_instance_profile_name)
                chech_policies_list = iam_instance_role(aws_access_key, aws_secret_key, Instance_profile_name=get_instance_profile_name, account_id=accountid)
                list_of_roles_with_max_policies.append(chech_policies_list)
                
            else:
                logging.info(" ssigning iam instance profile to instance "+Instance_Id)
                #Note: We need to use default instance profile in each aws account and provide as below
                instance_profile_arn="arn:aws:iam::"+accountid+":instance-profile/aws-ssm-role"
                #arn:aws:iam::xxxxxxxxx:instance-profile/aws-ssm-role
                logging.info(" Instance profile {} is assigning to instance {} ".format(instance_profile_arn,Instance_Id))
                associate_iam_profile = ec2_client.associate_iam_instance_profile(InstanceId=Instance_Id, IamInstanceProfile={"Arn":instance_profile_arn})
    logging.info( 5*" ")
    logging.info( 5*" ")
    list_of_roles_with_max_policies
    roles_with_max_policies = [*set(list_of_roles_with_max_policies)]
    logging.info(" List of Roles with 10 policies in it {}".format(roles_with_max_policies))
    return



if __name__ == "__main__":

    access_key=sys.argv[1].split('=')[1]
    secret_key=sys.argv[2].split('=')[1]
    account_id=sys.argv[3].split('=')[1]
    region = sys.argv[4].split('=')[1]
    executing_function = ec2_details(aws_access_key=access_key, aws_secret_key=secret_key, accountid=account_id, region=region)
    print(executing_function)
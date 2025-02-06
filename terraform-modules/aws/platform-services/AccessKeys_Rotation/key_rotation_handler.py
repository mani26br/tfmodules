import boto3
import os
from datetime import datetime, timedelta, timezone
from botocore.exceptions import ClientError

iam_client = session.client('iam')

def get_secret():

    secret_name = os.environ.get('SECRET_NAME')
    region_name = os.environ.get('REGION_NAME')


    # Create a Secrets Manager client
    session = boto3.session.Session()
    client = session.client(
        service_name='secretsmanager',
        region_name=region_name
    )

    try:
        get_secret_value_response = client.get_secret_value(
            SecretId=secret_name
        )
    except ClientError as e:
        raise e

    # Decrypts secret using the associated KMS key.
    secret = get_secret_value_response['SecretString']

secrets_manager_client = session.client('secretsmanager')
secret_name = 'SECRET_NAME'
rotated_users = []  # List to store information about rotated users

def get_access_key_age(user_name):
    try:
        response = iam_client.list_access_keys(UserName=user_name)
        for key in response['AccessKeyMetadata']:
            create_date = key['CreateDate']
            age_days = (datetime.now(timezone.utc) - create_date).days
            if age_days >=90:
                return True
        return False
    except Exception as e:
        print(f"Error fetching access keys for IAM User: {user_name}, Error: {e}")
        return False

rotated_users = []  # List to store information about rotated users

def rotate_access_keys(user_name):
    try:
        response = iam_client.list_access_keys(UserName=user_name)
        for key in response['AccessKeyMetadata']:
            access_key_id = key['AccessKeyId']
            iam_client.update_access_key(UserName=user_name, AccessKeyId=access_key_id, Status='Inactive')
            iam_client.delete_access_key(UserName=user_name, AccessKeyId=access_key_id)
            new_key_response = iam_client.create_access_key(UserName=user_name)
            new_access_key_id = new_key_response['AccessKey']['AccessKeyId']
            new_secret_access_key = new_key_response['AccessKey']['SecretAccessKey']
            rotated_users.append({
                'User': user_name,
                'OldAccessKeyId': access_key_id,
                'NewAccessKeyId': new_access_key_id,
                'NewSecretAccessKey': new_secret_access_key
            })
    except Exception as e:
        print(f"Error rotating access keys for IAM User: {user_name}, Error: {e}")

def main():
    try:
        print("iam in")
        response = iam_client.list_users()
        print("test1")
        for user in response['Users']:
            user_name = user['UserName']
            if get_access_key_age(user_name):
                print(f"IAM User: {user_name} has at least one Access Key older than 90 days.")               
                rotate_access_keys(user_name)
            else: 
                print("No users existed")

        #Push the rotated users information to AWS Secrets Manager
        if rotated_users:
            #print("rotated user list[]", rotated_users)
            secret_value = {
                'rotated_users': rotated_users
            }
            #print("secretvalue",secret_value)
            secrets_manager_client = session.client('secretsmanager')
            secret_name = "SECRET_NAME"
            #print("secretname", secret_name)
            secrets_manager_client.put_secret_value(
                SecretId=secret_name,
                SecretString=str(secret_value)
           )   
            print("Rotated user information pushed to Secrets Manager")

    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    secret_name = os.environ.get("SECRET_NAME")
    region_name = os.environ.get('REGION_NAME')
    main()

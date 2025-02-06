import json
import requests
import boto3
import os
from datetime import datetime, timedelta, timezone
from botocore.exceptions import ClientError
import subprocess

VAULT_URL = os.environ.get("VAULT_URL")
APPROLE_NAME = os.environ.get("VAULT_APPROLE")
ROLE_ID = os.environ.get("VAULT_ROLE_ID")
SECRET_ID = os.environ.get("VAULT_SECRET_ID")
# removed print statement that logged sensitive data
HEADERS = {'Content-Type': 'application/json'}

USER_NAME = os.environ.get("USER_NAME")

session = boto3.Session()

iam_client = session.client('iam')

rotated_users = []

# def generate_secret_id():
#     secret_id_command = [
#         "vault",
#         "write",
#         "-format=json",
#         f"auth/approle/role/{APPROLE_NAME}/secret-id",
#         f"role_id={ROLE_ID}",
#     ]
#     output = subprocess.check_output(secret_id_command)
#     data = json.loads(output.decode("utf-8"))
#     if 'data' in data and 'secret_id' in data['data']:
#         secret_id= data['data']['secret_id']
#         return secret_id
#     else:
#         raise Exception("Failed to generate Secret ID.")

def authenticate_with_approle(secret_id):
    auth_command = ["vault","write","-format=json","auth/approle/login",f"role_id={ROLE_ID}",f"secret_id={secret_id}",]
    output = subprocess.check_output(auth_command)
    data = json.loads(output.decode("utf-8"))
    if 'auth' in data and 'client_token' in data['auth']:
        token= data['auth']['client_token']
        print("Token Successfully authenticated", token)
        return token
    else:
        raise Exception("Failed to authenticate with AppRole.")

def write_secret_to_vault(secret_path, secret_data, token):
    try:
        # Convert the secret_data to a key-value string format
        secret_data_str = '\n'.join([f"{key}={value}" for key, value in secret_data.items()])

        # Write the secret data to Vault
        write_command = ["vault", "kv", "put", secret_path, f"token={token}", *secret_data_str.split('\n')]
        subprocess.check_output(write_command)

        print("Secret successfully written to Vault.")
    except Exception as e:
        print("Failed to write secret to Vault:", e)
     
def get_access_key_age(user_name):
    try:
        response = iam_client.list_access_keys(UserName=user_name)
        for key in response['AccessKeyMetadata']:
            create_date = key['CreateDate']
            age_days = (datetime.now(timezone.utc) - create_date).days
            if age_days >=150:
                return True
        return False
    except Exception as e:
        print(f"Error fetching access keys for IAM User: {user_name}, Error: {e}")
        return False    

def rotate_access_keys_and_write_to_vault(user_name, secret_path, token):
    rotated_users = []
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

    if rotated_users:
        secret_data = {'rotated_users': rotated_users}
        write_secret_to_vault(secret_path, secret_data, token)
        print("Rotated user information pushed to Vault")

def lambda_handler(event, lambda_context):
    user_name = event.get("user_name")  # Get the user_name from the event
    try:
        #secret_id = generate_secret_id()
        vault_token = authenticate_with_approle(SECRET_ID)

        # Define a dictionary where keys are usernames and values are lists of secret paths
        user_secret_paths = {}
        users = user_name
        for user in users:
            # Form the secret path using the username
            # secret_path is now a parameter passed to the function
            secret_path_with_user = f"{secret_path}/{user}"
            # Add the user and secret path to the dictionary
            user_secret_paths[user] = [secret_path_with_user]

        for user, paths in user_secret_paths.items():
            for secret_path in paths:
                rotate_access_keys_and_write_to_vault(user, secret_path, vault_token)

    except Exception as e:
        print(f"Error: {e}")

    return {
        'statusCode': 200,
        'body': json.dumps('Lambda execution completed successfully!')
    }
    
if __name__ == '__main__':
    # Example event data and lambda context
    event = {}
    context = {}

    # Example variable declarations from Terraform
    user_names = [USER_NAME]
    secret_path = [SECRET_PATH]

    # Invoke the lambda_handler function with the provided variables
    lambda_handler(event, context, secret_path)

             

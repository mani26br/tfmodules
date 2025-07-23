#!/usr/bin/env python3
import boto3
import botocore
from botocore.exceptions import NoCredentialsError, PartialCredentialsError, ClientError

TAGS_TO_CHECK = {"org", "project", "Name", "program", "environment", "access-team"}

def get_s3_buckets_with_tags(s3_client, key, key_value):
    s3_bucket_names = []
    key_s3_bucket_names = []

    try:
        response = s3_client.list_buckets()
        buckets = response['Buckets']

        for bucket in buckets:
            try:
                tags = s3_client.get_bucket_tagging(Bucket=bucket['Name'])['TagSet']
                s3_bucket_tags = {tag['Key']: tag['Value'] for tag in tags}
            except botocore.exceptions.ClientError as e:
                if e.response['Error']['Code'] == 'NoSuchTagSet':
                    s3_bucket_tags = {}
                else:
                    print(f"An error occurred: {e}")
                    continue

            if not TAGS_TO_CHECK.issubset(set(s3_bucket_tags.keys())):
                s3_bucket_names.append(bucket['Name'])
                print(f"S3 bucket {bucket['Name']} is missing one or more required tags")

                if key in s3_bucket_tags and s3_bucket_tags[key] == key_value:
                    key_s3_bucket_names.append(bucket['Name'])
                    print(f"S3 bucket {bucket['Name']} has '{key}: {key_value}'")

    except Exception as e:
        print(f"An error occurred: {e}")

    return s3_bucket_names, key_s3_bucket_names


def delete_s3_buckets(s3_client, s3_bucket_names):
    for bucket_name in s3_bucket_names:
        print("Deleting S3 bucket:", bucket_name)
        try:
            # Delete associated objects in the bucket before deleting the bucket
            delete_s3_objects(s3_client, bucket_name)

            # Delete other associated resources
            delete_s3_associated_resources(bucket_name)

            # Delete the bucket
            s3_client.delete_bucket(Bucket=bucket_name)
            print(f"S3 bucket {bucket_name} deleted successfully.")
        except Exception as e:
            print(f"Error deleting S3 bucket {bucket_name}: {e}")


def delete_s3_objects(s3_client, bucket_name):
    try:
        # List objects in the bucket
        response = s3_client.list_objects_v2(Bucket=bucket_name)

        # Delete each object in the bucket
        for obj in response.get('Contents', []):
            s3_client.delete_object(Bucket=bucket_name, Key=obj['Key'])
            print(f"Deleted object {obj['Key']} from S3 bucket {bucket_name}")
    except Exception as e:
        print(f"Error deleting objects in S3 bucket {bucket_name}: {e}")


def delete_s3_associated_resources(bucket_name):
    # Add logic to delete additional associated resources here
    print(f"Deleting associated resources for S3 bucket {bucket_name}")


def s3_buckets(key, key_value):
    s3_client = boto3.client('s3')
    s3_bucket_names_without_tags, key_s3_bucket_names = get_s3_buckets_with_tags(s3_client, key, key_value)

    for bucket_name in s3_bucket_names_without_tags:
        print("S3 bucket without required tags:", bucket_name)

    for bucket_name in key_s3_bucket_names:
        print(f"{key_value} S3 bucket with required tags:", bucket_name)

    # To delete S3 buckets without required tags
    #delete_s3_buckets(s3_client, s3_bucket_names_without_tags)

    # To delete S3 buckets with specific tags
    delete_s3_buckets(s3_client, key_s3_bucket_names)
#!/usr/bin/env python3
import boto3
from botocore.exceptions import NoCredentialsError, PartialCredentialsError, ClientError

TAGS_TO_CHECK = {"org", "project", "Name", "program", "environment", "access-team"}

def get_ecr_repositories_with_tags(ecr_client, key, key_value):
    ecr_repository_names = []
    key_ecr_repository_names = []

    try:
        response = ecr_client.describe_repositories()
        repositories = response['repositories']

        for repository in repositories:
            try:
                tags = ecr_client.list_tags_for_resource(resourceArn=repository['repositoryArn'])['tags']
                ecr_repository_tags = {tag: tags[tag] for tag in tags}
            except ecr_client.exceptions.RepositoryNotFoundException:
                ecr_repository_tags = {}

            if not TAGS_TO_CHECK.issubset(set(ecr_repository_tags.keys())):
                ecr_repository_names.append(repository['repositoryName'])
                print(f"ECR repository {repository['repositoryName']} is missing one or more required tags")

                if key in ecr_repository_tags and ecr_repository_tags[key] == key_value:
                    key_ecr_repository_names.append(repository['repositoryName'])
                    print(f"ECR repository {repository['repositoryName']} has '{key}: {key_value}'")

    except Exception as e:
        print(f"An error occurred: {e}")

    return ecr_repository_names, key_ecr_repository_names

def delete_ecr_repository_images(ecr_client, repository_name):
    try:
        response = ecr_client.list_images(repositoryName=repository_name)
        image_details = response.get('imageDetails', [])

        for image in image_details:
            image_digest = image['imageDigest']
            print(f"Deleting image {image_digest} from ECR repository {repository_name}")
            ecr_client.batch_delete_image(repositoryName=repository_name, imageIds=[{'imageDigest': image_digest}])

        print(f"All images deleted from ECR repository {repository_name}")
    except Exception as e:
        print(f"Error deleting images in ECR repository {repository_name}: {e}")

def delete_ecr_repositories(ecr_client, ecr_repository_names):
    for repository_name in ecr_repository_names:
        print("Deleting ECR repository:", repository_name)
        try:
            # Delete associated images in the repository before deleting the repository
            delete_ecr_repository_images(ecr_client, repository_name)

            # Delete the repository
            ecr_client.delete_repository(repositoryName=repository_name, force=True)
            print(f"ECR repository {repository_name} deleted successfully.")
        except Exception as e:
            print(f"Error deleting ECR repository {repository_name}: {e}")

def ecr_repositories(key, key_value):
    ecr_client = boto3.client('ecr')
    ecr_repository_names_without_tags, key_ecr_repository_names = get_ecr_repositories_with_tags(ecr_client, key, key_value)

    for repository_name in ecr_repository_names_without_tags:
        print("ECR repository without required tags:", repository_name)

    for repository_name in key_ecr_repository_names:
        print(f"{key_value} ECR repository with required tags:", repository_name)

    # Uncomment the following line to delete ECR repositories without required tags
    # delete_ecr_repositories(ecr_client, ecr_repository_names_without_tags)

    # Uncomment the following line to delete ECR repositories with specific tags
    delete_ecr_repositories(ecr_client, key_ecr_repository_names)



#!/usr/bin/env python3
import boto3
import argparse
from botocore.exceptions import NoCredentialsError, PartialCredentialsError, ClientError

TAGS_TO_CHECK = {"org", "project", "Name", "program", "environment", "access-team"}

def get_eks_clusters_with_tags(eks_client, key, key_value):
    eks_cluster_names = []
    key_eks_cluster_names = []

    try:
        response = eks_client.list_clusters()
        clusters = response['clusters']

        for cluster_name in clusters:
            try:
                # Describe the cluster to get its ARN
                cluster_info = eks_client.describe_cluster(name=cluster_name)
                cluster_arn = cluster_info['cluster']['arn']

                # Get tags using the correct ARN format
                tags = eks_client.list_tags_for_resource(resourceArn=cluster_arn)['tags']
                eks_cluster_tags = {tag['key']: tag['value'] for tag in tags}
            except eks_client.exceptions.ResourceNotFoundException:
                eks_cluster_tags = {}

            if not TAGS_TO_CHECK.issubset(set(eks_cluster_tags.keys())):
                eks_cluster_names.append(cluster_name)
                print(f"EKS cluster {cluster_name} is missing one or more required tags")

                if key in eks_cluster_tags and eks_cluster_tags[key] == key_value:
                    key_eks_cluster_names.append(cluster_name)
                    print(f"EKS cluster {cluster_name} has '{key}: {key_value}'")

    except Exception as e:
        print(f"An error occurred: {e}")

    return eks_cluster_names, key_eks_cluster_names

def delete_eks_cluster(eks_client, cluster_name):
    try:
        # Delete associated resources (worker nodes)
        delete_eks_associated_resources(eks_client, cluster_name)

        # Delete the EKS cluster
        eks_client.delete_cluster(name=cluster_name)
        print(f"EKS cluster {cluster_name} deleted successfully.")
    except Exception as e:
        print(f"Error deleting EKS cluster {cluster_name}: {e}")

def delete_eks_associated_resources(eks_client, cluster_name):
    # Add logic to delete additional associated resources here
    print(f"Deleting associated resources for EKS cluster {cluster_name}")

def delete_eks_clusters(eks_client, eks_cluster_names):
    for cluster_name in eks_cluster_names:
        print("Deleting EKS cluster:", cluster_name)
        delete_eks_cluster(eks_client, cluster_name)

def eks_clusters(key, key_value):
    eks_client = boto3.client('eks')
    eks_cluster_names_without_tags, key_eks_cluster_names = get_eks_clusters_with_tags(eks_client, key, key_value)

    for cluster_name in eks_cluster_names_without_tags:
        print("EKS cluster without required tags:", cluster_name)

    for cluster_name in key_eks_cluster_names:
        print(f"{key_value} EKS cluster with required tags:", cluster_name)

    # Uncomment the following line to delete EKS clusters without required tags
    # delete_eks_clusters(eks_client, eks_cluster_names_without_tags)

    # Uncomment the following line to delete EKS clusters with specific tags
    delete_eks_clusters(eks_client, key_eks_cluster_names)


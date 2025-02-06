# lambda_handler.py
import os
from LambdaFunction.ec2_decommission import instance_ids 
from LambdaFunction.s3_decommission import s3_buckets
from LambdaFunction.rds_decommission import rds_instances
from LambdaFunction.elastic_ips_decommission import elastic_ips
from LambdaFunction.alb_decommission import albs 
from LambdaFunction.vpc_decommission import vpcs
from LambdaFunction.ecr_decommission import ecr_repositories
from LambdaFunction.eks_decommission import eks_clusters
from LambdaFunction.asgs_decommission import asgs

def lambda_handler(event, context):
    # key_value = os.environ.get("KEY_VALUE")
    # key = os.environ.get("KEY")
    key_value = "decommissioned"
    key = "decor"
    # Based on the event or resource type, call the appropriate handler
    try: 
        instance_ids(key, key_value)
        s3_buckets(key, key_value)
        elastic_ips(key, key_value)
        albs(key, key_value)
        rds_instances(key, key_value)
        vpcs(key, key_value)
        ecr_repositories(key, key_value)
        eks_clusters(key, key_value)
        asgs(key, key_value)
    except:
        print("error occured")               

if __name__ == '__main__':
    lambda_handler({}, {})




# Import other resource type handlers
# def lambda_handler(event, context):
#     # Based on the event or resource type, call the appropriate handler
#     if event.get('resource_type') == 'ec2':
#         ec2_lambda_handler(event, context)
#     elif event.get('resource_type') == 's3':
#         s3_lambda_handler(event, context)
#     elif event.get('resource_type') == 'rds':
#         rds_lambda_handler(event, context) 
#     elif event.get('resource_type') == 'elastic_ips':
#         elastic_ips_lambda_handler(event, context)
#     elif event.get('resource_type') == 'vpc':
#         vpc_lambda_handler(event, context)     
#     elif event.get('resource_type') == 'alb':
#         alb_lambda_handler(event, context)     
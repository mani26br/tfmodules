import boto3
import os
from datetime import datetime
import pytz

sns_client = boto3.client('sns')

def notify_via_sns(subject, message, sns_topic_arns, project):
    responses = []
    # Ensure that at least one SNS topic is available
    if not sns_topic_arns:
        raise ValueError("SNS_TOPIC_ARN environment variable not set")

    # Prepare the message attributes (only for project)
    message_attributes = {
        'Projects': {
            'DataType': 'String',
            'StringValue': project
        }
    }

    # Publish message to each SNS topic
    for sns_topic_arn in sns_topic_arns:
        response = sns_client.publish(
            TopicArn=sns_topic_arn,
            Subject=subject,
            Message=message,
            MessageAttributes=message_attributes
        )
        responses.append(response)

    return responses

def lambda_handler(event, context):
    # Use event.get() for environment variables or default values
    sns_topic_arns = event.get('SNS_TOPIC_ARN', [])  # Should be a list of SNS topic ARNs
    project = event.get('PROJECT', '')  # Default to 'common' if not provided
    action = event.get('ACTION', '')  # Default action is 'start'
    environment = event.get('ENVIRONMENT', '')  # Get environment
    account = event.get('ACCOUNT', '')  # Get account
    timezone = event.get('TIMEZONE', 'US/Eastern')  # Default to Eastern Time

    # Convert the current time to the specified timezone
    tz = pytz.timezone(timezone)
    timestamp = datetime.now(tz).strftime('%Y-%m-%d %H:%M:%S %Z')

    # Send SNS notification to all specified topics
    sns_responses = notify_via_sns(
        subject=f"AWS Resources {action} Instances - {project} ({account}) {timestamp}",
        message=f"""
        Projects: {project}
        Environment: {environment}
        AWS Account: {account}
        Action: {action}
        Time: {timestamp}
        """,
        sns_topic_arns=sns_topic_arns,
        project=project  # Pass project as the message attribute
    )
    
    # Return the responses from the SNS publish calls
    return sns_responses

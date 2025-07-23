import boto3
import logging
import os
from datetime import datetime, timezone

def delete_recovery_points(vault_name, start_date, end_date):
    """Deletes EBS volume snapshots within a specified date range."""

    client = boto3.client('backup')
    paginator = client.get_paginator('list_recovery_points_by_backup_vault')

    for response in paginator.paginate(BackupVaultName=vault_name):
        for recovery_point in response['RecoveryPoints']:
            creation_date = recovery_point['CreationDate'].replace(tzinfo=timezone.utc)

            if start_date <= creation_date <= end_date:
                if recovery_point['ResourceType'] == 'EBS':
                    try:
                        client.delete_recovery_point(
                            BackupVaultName=vault_name,
                            RecoveryPointArn=recovery_point['RecoveryPointArn']
                        )
                        logging.info(f"Deleted EBS snapshot: {recovery_point['RecoveryPointArn']}")
                    except Exception as e:
                        logging.error(f"Error deleting recovery point: {e}")
                else:
                    logging.info(f"Skipped non-EBS resource: {recovery_point['ResourceType']} - {recovery_point['RecoveryPointArn']}")

def lambda_handler(event, context):
    """AWS Lambda entry point."""
    vault_name = os.getenv('VAULT_NAME', 'Default')
    start_date_str = os.getenv('START_DATE')
    end_date_str = os.getenv('END_DATE')

    if not start_date_str or not end_date_str:
        logging.error("Missing START_DATE or END_DATE in environment variables.")
        return {"status": "error", "message": "Missing START_DATE or END_DATE"}

    try:
        start_date = datetime.fromisoformat(start_date_str).replace(tzinfo=timezone.utc)
        end_date = datetime.fromisoformat(end_date_str).replace(tzinfo=timezone.utc)
    except ValueError as e:
        logging.error(f"Invalid date format: {e}")
        return {"status": "error", "message": "Invalid date format"}

    delete_recovery_points(vault_name, start_date, end_date)

    return {"status": "success", "message": "Snapshot deletion completed."}

#!/bin/bash

# Replace with your secret name and AWS region
SECRET_NAME="dev/test"
REGION="eu-west-1"

# Get secret value
SECRET_JSON=$(aws secretsmanager get-secret-value \
    --secret-id "$SECRET_NAME" \
    --region "$REGION" \
    --query SecretString \
    --output text)

# Parse and export each variable
export DB_HOST=$(echo $SECRET_JSON | jq -r '.DB_HOST')
export DB_USER=$(echo $SECRET_JSON | jq -r '.DB_USER')
export DB_PASS=$(echo $SECRET_JSON | jq -r '.DB_PASS')
export DB_NAME=$(echo $SECRET_JSON | jq -r '.DB_NAME')

# Optional: print to confirm
echo "Environment variables set."

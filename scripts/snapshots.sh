#!/bin/bash

# AWS profile name
profile="switcher.ai"

# List of AWS regions (add or remove regions as needed)
regions=("us-east-1" "us-east-2" "us-west-2" "us-west-1" "ap-southeast-1" "eu-west-1" "sa-east-1" "ap-northeast-1" "ap-southeast-2" "ap-northeast-2" "ap-south-1" "eu-central-1" "eu-west-2" "ca-central-1" "us-east-1" "us-east-2" "us-west-2" "us-west-1" "ap-southeast-1" "eu-west-1" "sa-east-1" "ap-northeast-1" "ap-southeast-2" "ap-northeast-2" "ap-south-1" "eu-central-1" "eu-west-2" "ca-central-1")

# Iterate through regions
for region in "${regions[@]}"; do
    echo "Region: $region"
    
    # Use AWS CLI to describe snapshots in the current region
    aws ec2 describe-snapshots --owner-ids 705197526668  --region "$region" --profile "$profile"
    
    # Add a separator between regions
    echo "------------------------------------"
done


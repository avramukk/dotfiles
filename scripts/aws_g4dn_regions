#!/bin/bash

# List of regions to check
regions=("us-east-2" "us-east-1" "us-west-1" "us-west-2" "af-south-1" "ap-east-1" "ap-south-1" "ap-northeast-2" "ap-southeast-1" "ap-southeast-2" "ap-northeast-1" "ca-central-1" "eu-central-1" "eu-west-1" "eu-west-2" "eu-south-1" "eu-west-3" "eu-north-1" "me-south-1" "ap-northeast-3" "sa-east-1")

# AWS CLI profile to use
profile="dev-apps"

# Output file
output_file="g4dn_availability.txt"

# Clear output file if it exists
> "$output_file"

# Loop through each region
for region in "${regions[@]}"; do
    echo "Checking availability in $region..."
    available_types=$(aws ec2 describe-instance-type-offerings \
        --filters "Name=instance-type,Values=g4dn*" \
        --query "InstanceTypeOfferings[].InstanceType" \
        --output text \
        --region "$region" \
        --profile "$profile")
    
    echo "[$region]: $available_types" >> "$output_file"
done

echo "Availability check complete. Results saved in $output_file"

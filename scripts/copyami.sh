#!/bin/bash

# Source AMI ID and region
SOURCE_AMI_ID="ami-046e5a00df63ae8d6"  # Replace with your source AMI ID
SOURCE_REGION="us-east-1"  # Replace with your source region

# Target regions
declare -a TARGET_REGIONS=("us-east-2" "us-west-1" "us-west-2" "eu-central-1" "sa-east-1" "ca-central-1")

# Function to copy AMI to a target region
copy_ami() {
    local target_region=$1
    local new_ami_name="mce-mixa"

    echo "Copying $SOURCE_AMI_ID to $target_region..."
    aws ec2 copy-image --source-image-id "$SOURCE_AMI_ID" --source-region "$SOURCE_REGION" --region "$target_region" --name "mce-mixa" --profile mixa
}

# Iterate over target regions and copy the AMI
for region in "${TARGET_REGIONS[@]}"; do
    copy_ami "$region"
done

echo "AMI copy operations initiated."


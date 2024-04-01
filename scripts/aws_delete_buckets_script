#!/bin/bash

# Check for the correct number of arguments
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <aws_profile> <bucket_name1> [bucket_name2 ...]"
    exit 1
fi

# Assign the first argument to the AWS profile
aws_profile="$1"
shift 1

# Loop through the remaining arguments (bucket names)
for bucket_name in "$@"; do
    # Step 1: Delete all objects within the bucket
    echo "Deleting objects in the bucket: $bucket_name"
    aws s3 rm "s3://$bucket_name" --recursive --profile "$aws_profile"

    # Step 2: Delete the empty bucket
    echo "Deleting the bucket: $bucket_name"
    aws s3 rb "s3://$bucket_name" --profile "$aws_profile"

    echo "Bucket '$bucket_name' and its objects have been deleted."
done


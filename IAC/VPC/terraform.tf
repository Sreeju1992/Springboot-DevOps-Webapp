terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket1992"   # Replace with your S3 bucket name
    key            = "VPCstatefile" # Path within the bucket where the state file will be stored
    region         = "us-east-1"                    # Replace with your desired AWS region
    encrypt        = true                           # Encrypt the state file at rest
    dynamodb_table = "state-locking"      # Replace with your DynamoDB table name
  }
}
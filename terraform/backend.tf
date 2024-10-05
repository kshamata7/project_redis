terraform {
  backend "s3" {
    bucket         = "redis-kshamata-bucket"      # Your S3 bucket name
    key            = "terraform/statefile.tfstate"  # Path to store state file in S3
    region         = "us-east-1"               # AWS region
    encrypt        = true                      # Enable encryption
    dynamodb_table = "demo"    # DynamoDB table for state locking
  }
}

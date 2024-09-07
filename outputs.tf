# Output the EC2 instance public IP
output "instance_public_ip" {
  value = aws_instance.web.public_ip
}

# Output the S3 bucket name
output "s3_bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}

# Output the DynamoDB table name
output "dynamodb_table_name" {
  value = aws_dynamodb_table.my_table.name
}

# Output the VPC ID
output "vpc_id" {
  value = aws_vpc.main.id
}

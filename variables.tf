# Variables
variable "aws_region" {
  description = "The AWS region to deploy resources"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  default     = "terraform-dynamodb-table"
}

variable "s3_bucket_name" {
  description = "S3 bucket name"
  default     = "terraform-s3-bucket-example"
}
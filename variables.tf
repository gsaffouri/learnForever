# AWS Region
variable "region" {
  type        = string
  description = "The AWS region to deploy resources in"
  default     = "us-west-2"
}

# VPC Settings
variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC"
  default     = "MainVPC"
}

# Subnet Settings
variable "subnet_cidr" {
  type        = string
  description = "CIDR block for the subnet"
  default     = "10.0.1.0/24"
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet"
  default     = "MainSubnet"
}

variable "availability_zone" {
  type        = string
  description = "The availability zone for the subnet"
  default     = "us-west-2a"
}

# Internet Gateway
variable "igw_name" {
  type        = string
  description = "The name of the internet gateway"
  default     = "MainIGW"
}

# Route Table
variable "route_table_name" {
  type        = string
  description = "The name of the route table"
  default     = "MainRouteTable"
}

# Security Group
variable "security_group_name" {
  type        = string
  description = "The name of the security group"
  default     = "MainSecurityGroup"
}

# EC2 Instance Settings
variable "ami" {
  type        = string
  description = "AMI ID for the EC2 instance"
  default     = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
  type        = string
  description = "Instance type for the EC2 instance"
  default     = "t2.micro"
}

variable "ec2_instance_name" {
  type        = string
  description = "The name of the EC2 instance"
  default     = "WebServer"
}

# S3 Bucket Settings
variable "s3_bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
  default     = "my-terraform-bucket-12345"
}

variable "s3_acl" {
  type        = string
  description = "The ACL for the S3 bucket"
  default     = "private"
}

# DynamoDB Table Settings
variable "dynamodb_table_name" {
  type        = string
  description = "The name of the DynamoDB table"
  default     = "my-dynamodb-table"
}

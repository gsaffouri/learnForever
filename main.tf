# Provider configuration (AWS)
provider "aws" {
  region = "us-west-2"
}

# -----------------------------
# 1. VPC Configuration
# -----------------------------

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "MainVPC"
  }
}

# Create a Subnet in the VPC
resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  tags = {
    Name = "MainSubnet"
  }
}

# Create an Internet Gateway for the VPC
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "MainIGW"
  }
}

# Create a Route Table for the VPC
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "MainRouteTable"
  }
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

# Create a Security Group that allows SSH and HTTP
resource "aws_security_group" "main" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # SSH access from anywhere, adjust as needed
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # HTTP access from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }

  tags = {
    Name = "MainSecurityGroup"
  }
}

# -----------------------------
# 2. EC2 Instance Configuration
# -----------------------------

# Create an EC2 instance within the VPC
resource "aws_instance" "web" {
  ami                    = "ami-0c55b159cbfafe1f0"  # AMI ID (use the appropriate AMI for your region)
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.main.id]

  tags = {
    Name = "WebServer"
  }

  # Add user data script if you want to initialize the instance with some commands
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y nginx
              EOF
}

# -----------------------------
# 3. S3 Bucket Configuration
# -----------------------------

# Create an S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-terraform-bucket-12345"  # Bucket names must be globally unique
  acl    = "private"

  tags = {
    Name        = "MyS3Bucket"
    Environment = "Dev"
  }
}

# -----------------------------
# 4. DynamoDB Table Configuration
# -----------------------------

# Create a DynamoDB table
resource "aws_dynamodb_table" "my_table" {
  name           = "my-dynamodb-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"  # 'S' stands for string
  }

  tags = {
    Name        = "MyDynamoDBTable"
    Environment = "Dev"
  }
}

# -----------------------------
# 5. Outputs
# -----------------------------

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

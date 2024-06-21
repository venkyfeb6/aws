# Configure Terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.52.0"
    }
  }
}
 
# Configure AWS Provider
provider "aws" {
  region = "us-west-1" # Update with your desired region
}
 
# Create a Security Group
resource "aws_security_group" "allow_all" {
  name = "allow_ssh_http"
  description = "Allows SSH and HTTP traffic from anywhere"
 
  ingress {
    from_port = 22
    to_port   = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  ingress {
    from_port = 80
    to_port   = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    from_port = 0
    to_port   = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
 
# Launch an EC2 Instance
resource "aws_instance" "webserver" {
  ami           = "ami-0aafdae616ee7c9b7"
  instance_type = "t2.micro" 
  key_name      = "Softtek"
 
vpc_security_group_ids = [aws_security_group.allow_all.id]
 
  # User data script to install Apache and modify index.html
  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install apache2 -y
    echo "welcome to softtek" | sudo tee /var/www/html/index.html
    sudo systemctl restart apache2
  EOF
 
  tags = {
    Name = "Softtek Webserver"
  }
}
 

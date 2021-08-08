terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  access_key = "access_key"
  secret_key = "secret_key"
}

# Create a VPC
#resource "aws_vpc" "example" {
 # cidr_block = "10.0.0.0/16"
  
  #tags {
    #Name = "example"
  #}
#}


module "my_vpc" {
  source      = "../modules/vpc"
  vpc_cidr    = "192.168.0.0/16"
  tenancy     = "default"
  vpc_id      = "${module.my_vpc.vpc_id}"
  subnet_cidr = "192.168.1.0/24"
}


module "my_ec2" {
  source        = "../modules/ec2"
  ec2_count     = 1
  ami_id        = "ami-0747bdcabd34c712a"
  instance_type = "t2.micro"
  subnet_id     = "${module.my_vpc.subnet_id}"
}
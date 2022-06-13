# instance_type = "t2.small"

# vpc_cidr = "10.0.0.0/16"





# provider "aws" {
#   region  = "ap-south-1"
#   profile = "mykey"
# }

# resource "aws_vpc" "my-vpc" {
# cidr_block =  var.vpc_cidr
# instance_tenancy = "default"
# tags {
#     Name = "Sayali_Terraform"
#     Purpose = "Terraform"
# }
  
# }


# resource "aws_instance" "demo-ec2" {
#     ami = "ami-079b5e5b3971bd10d"
#     instance_type = var.instance type

#     tags = {
#       "Name" = "Terraform ec2"

#     }


# }
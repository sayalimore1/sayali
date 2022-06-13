
variable "vpc_cidr" {
 description = "vpc cidr"
 type = string
 default = "10.0.0.0/24" 
}


variable "subnetpub_cidr" {
    description = "subnetpub cidr"
    type = string
    default = "10.0.0.0/25"
  
}
variable "subnetpvt_cidr" {
    description = "subnetpvt cidr"
    type = string
    default = "10.0.0.128/25"
  
}


variable "instance_type" {
  description = "instance_type"
  type = string
  default = "t2.micro"
  
}
variable "instance_type1" {
  description = "instance_type1"
  type = string
  default = "t2.micro"

}


# variable "instance_type" {
#   description = "instance type"
#   type = string
#   default = "t2.micro"
  
# }


# resource "aws_vpc" "demo-vpc" {
#   cidr_block = "var.ip"

#   tags = {
#     Name = "Sayali_vpc"
#     Owner = "Sayali"
#     Purpose = "Terraform_practice"
#   }
  
# }


# variable "vpc_cidr" {
#   default = "190.160.0.0/16"
# }

  
# }



# provider "aws" {
#   region  = "ap-south-1"
#   profile = "mykey"
# }
# # for s3 bucket

# resource "aws_s3_bucket" "s3" {
#   bucket = "bucket-to-test-terraform"
#   acl = "private"

  
#   versioning {
#     enabled = true 

  
#   }
# }











































# variable "my_IP"{
#     description = "ip"

# }
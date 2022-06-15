provider "aws" {
  region  = "ap-south-1"
  
}

# Creating VPC
resource "aws_vpc" "demo-vpc" {
cidr_block =  var.vpc_cidr
instance_tenancy = "default"

tags = {
    Name = "Sayali_Vpc"
    Purpose = "Project 1"
    Owner = "Sayali"
}
  
}



# Creating Public subnet

resource "aws_subnet" "subnet-pub" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = var.subnetpub_cidr
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "Sayali_Subnet_pub"
    Purpose = "Project 1"
    Owner = "Sayali"
  }
}

# # # Creating private subnet

resource "aws_subnet" "subnet-pvt" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = var.subnetpvt_cidr
  availability_zone = "ap-south-1b"
  tags = {
    Name = "Sayali_Subnetpvt"
    Purpose = "Project 1"
    Owner = "Sayali"
  }
}


# # # Creating NAT Gateway

# # resource "aws_nat_gateway" "Sayali_NG" {
# #   allocation_id = aws_eip.sayali_eip.id
# #   subnet_id     = aws_subnet.subnet-pvt.id

# #   tags = {
# #     Name = "Sayali_NG"
# #   }
# #    depends_on = [aws_internet_gateway.gw]
# # }

# 3. Create Custom Route Table


# Creating internet gateway



resource "aws_internet_gateway" "Sayali-gw" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "Sayaligw"
  }
}

# 3. Create Custom Route Table

resource "aws_route_table" "Pub_route_table" {
  vpc_id = aws_vpc.demo-vpc.id
   tags = {
    Name = "Sayali"
  }
}

# # #  Associate subnet with Route Table

resource "aws_route_table_association" "Pub-RT" {
  subnet_id      = aws_subnet.subnet-pub.id
  route_table_id = aws_route_table.Pub_route_table.id
}
 
resource "aws_route" "Routes"{
    route_table_id = aws_route_table.Pub_route_table.id
    destination_cidr_block  = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Sayali-gw.id
  } 



resource "aws_route_table" "Pvt_route_table" {
  vpc_id = aws_vpc.demo-vpc.id
 

  tags = {
    Name = "Sayali"
  }
}

resource "aws_route_table_association" "Pvt-RT" {
  subnet_id      = aws_subnet.subnet-pvt.id
  route_table_id = aws_route_table.Pvt_route_table.id
}
  

# #  Create Security Group to allow port 22,80

resource "aws_security_group" "Sayali-sg" {
  name        = "Sayali_Security grp"
  description = "Allow web inbound traffic"
  vpc_id      = aws_vpc.demo-vpc.id
  


  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["182.73.28.2/32"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["182.73.28.2/32"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Sayali_sg"
    Purpose = "Project 1"
    Owner = "Sayali"
  }
}


# 7. Create a network interface 

# resource "aws_network_interface" "web-server" {
#   subnet_id       = aws_subnet.subnet-pub.id
#   private_ips     = ["10.0.0.20"]
#   security_groups = [aws_security_group.Sayali-sg.id]
# }

# # # 8. Assign an elastic IP to the network interface

# # resource "aws_eip" "sayali_eip" {
# #   vpc                       = true
# #   network_interface         = aws_network_interface.web-server.id
# #   associate_with_private_ip = "10.0.0.20"
# # #   depends_on = [aws_internet_gateway.gw]
# # # }


resource "aws_spot_instance_request" "sayali_Server_pub" {
  ami = "ami-079b5e5b3971bd10d"
  spot_price             = "0.03"
  instance_type          = "t2.micro"
  spot_type              = "one-time"
  wait_for_fulfillment   = "true"
  # associate_public_ip_address = true
  subnet_id = aws_subnet.subnet-pub.id
  key_name               = "Sayali_key"
  security_groups = [aws_security_group.Sayali-sg.id]

   tags = {
      Name = "Sayali_Server_pub"
      Purpose = "Project 1"
      Owner = "Sayali"
    
    }
}
resource "aws_spot_instance_request" "sayali_Server_pvt" {
  ami = "ami-079b5e5b3971bd10d"
  spot_price             = "0.03"
  instance_type          = "t2.micro"
  spot_type              = "one-time"
  wait_for_fulfillment   = "true"
  subnet_id = aws_subnet.subnet-pvt.id
  key_name               = "Sayali_key"
  security_groups = [aws_security_group.Sayali-sg.id]

   tags = {
      Name = "Sayali_Server_pvt"
      Purpose = "Project 1"
      Owner = "Sayali"
    
    }

}
}
output "instance_Pub_ip" {
  value = aws_spot_instance_request.sayali_Server_pub.public_ip
}
output "instance_Pvt_ip" {
  value = aws_spot_instance_request.sayali_Server_pvt.private_ip
}





















# resource "aws_instance" "demo-ec2_1" {
#     ami = "ami-079b5e5b3971bd10d"
#     instance_type = var.instance_type
#     subnet_id = aws_subnet.subnet-pub.id
#     key_name = "Sayali_key"

#   #   network_interface {
#   #     device_index = 0
#   #     network_interface_id = aws_network_interface.web-server.id
#   # }

#     tags = {
#       Name = "Sayali_Server1"
#       Purpose = "Project 1"
#       Owner = "Sayali"
    
#     }
# }


# resource "aws_instance" "demo-ec2_2" {
#     ami = "ami-079b5e5b3971bd10d"
#     instance_type = var.instance_type1
#     subnet_id = aws_subnet.subnet-pvt.id
#     key_name = "Sayali_key"


#     tags = {
#       Name = "Sayali_Server2"
#       Purpose = "Project 1"
#       Owner = "Sayali"
    
#     }
# }


 


# resource "aws_instance" "demo-ec2" {
#     ami = "ami-079b5e5b3971bd10d"
#     instance_type = var.instance_type
#     key_name = "Sayali_key"

#     tags = {
#       Name = "Task-server"
#       Owner= "Sayali"
#       Purpose = "Task"      
      
#     }
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


# create vpc
resource "aws_vpc" "vpc" {
  cidr_block              = var.vpc_cidr
  instance_tenancy        = "default"
  enable_dns_hostnames    = true

  tags      = {
    Name    = "${var.project_name}-vpc"
  }
}

#Create Internet Gateway and attach it to VPC
resource "aws_internet_gateway" "IGW" { # Creating Internet Gateway
  vpc_id = aws_vpc.vpc.id  # vpc_id will be generated after we create VPC

   tags      = {
    Name    = "${var.project_name}-igw"
  }
}         

#Create a Public Subnets.
resource "aws_subnet" "public_subnets" { # Creating Public Subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "${var.publicsubnets_cidr[0]}" # CIDR block of public subnets
  availability_zone = var.public_AZ[1]  # assign AZ us-east-1a
  map_public_ip_on_launch = true
  tags = {
    name = "public"
  }

}
#Create a Private Subnet                   # Creating Private Subnets
resource "aws_subnet" "private_subnets" {
  #name = "private"
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "${var.privatesubnets_cidr[0]}"  # CIDR block of private subnets
  availability_zone = "${var.private_AZ[1]}"    # assign AZ us-east-1f
  map_public_ip_on_launch = false
  
  tags = {
    name = "private"
  }

}



#Route table for Public Subnet's
resource "aws_route_table" "PublicRT" { # Creating RT for Public Subnet
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0" # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.IGW.id


  }

      tags = {
    name = "public route table"
  }
}
# Route table for Private Subnet's
resource "aws_route_table" "PrivateRT" { # Creating RT for Private Subnet
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0" # Traffic from Private Subnet reaches Internet via NAT Gateway
    nat_gateway_id = aws_nat_gateway.NATgw.id

  }

      tags = {
    name = "private route table"
  }
}


# Route table Association with Public Subnet's
resource "aws_route_table_association" "PublicRTassociation" {
  subnet_id      = aws_subnet.public_subnets.id
  route_table_id = aws_route_table.PublicRT.id

}
# Route table Association with Private Subnet's
resource "aws_route_table_association" "PrivateRTassociation" {
  subnet_id      = aws_subnet.private_subnets.id
  route_table_id = aws_route_table.PrivateRT.id

}

resource "aws_eip" "nateIP" {
  vpc = true
}
# Creating the NAT Gateway using subnet_id and allocation_id
resource "aws_nat_gateway" "NATgw" {
  allocation_id = aws_eip.nateIP.id
  subnet_id     = aws_subnet.public_subnets.id
}


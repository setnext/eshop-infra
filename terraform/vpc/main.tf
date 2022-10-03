
resource "aws_vpc" "eshop_vpc" {        # Creating VPC here
  cidr_block       = var.eshop_vpc_cidr # Defining the CIDR block use 10.0.0.0/24 for demo
  instance_tenancy = "default"
}

resource "aws_internet_gateway" "eshop_IGW" { # Creating Internet Gateway
  vpc_id = aws_vpc.eshop_vpc.id                # vpc_id will be generated after we create VPC
}

resource "aws_subnet" "eshop_publicsubnet" { # Creating Public Subnets
  vpc_id     = aws_vpc.eshop_vpc.id
  cidr_block = var.eshop_publicsubnet # CIDR block of public subnets
}
# Creating Private Subnets
resource "aws_subnet" "eshop_privatesubnet" {
  vpc_id     = aws_vpc.eshop_vpc.id
  cidr_block = var.eshop_privatesubnet # CIDR block of private subnets
}

resource "aws_route_table" "eshop_PublicRT" { # Creating RT for Public Subnet
  vpc_id = aws_vpc.eshop_vpc.id
  route {
    cidr_block = "0.0.0.0/0" # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.eshop_IGW.id
  }
}

resource "aws_route_table" "eshop_PrivateRT" { # Creating RT for Private Subnet
  vpc_id = aws_vpc.eshop_vpc.id
  route {
    cidr_block     = "0.0.0.0/0" # Traffic from Private Subnet reaches Internet via NAT Gateway
    nat_gateway_id = aws_nat_gateway.eshop_NATgw.id
  }
}

resource "aws_route_table_association" "eshop_PublicRTassociation" {
  subnet_id      = aws_subnet.eshop_publicsubnet.id
  route_table_id = aws_route_table.eshop_PublicRT.id
}

resource "aws_route_table_association" "eshop_PrivateRTassociation" {
  subnet_id      = aws_subnet.eshop_privatesubnet.id
  route_table_id = aws_route_table.eshop_PrivateRT.id
}
resource "aws_eip" "eshop_nateIP" {
  vpc = true
}

resource "aws_nat_gateway" "eshop_NATgw" {
  allocation_id = aws_eip.eshop_nateIP.id
  subnet_id     = aws_subnet.eshop_publicsubnet.id
}

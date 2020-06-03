resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = format("%s-vpc", local.product_name)
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = format("%s-igw", local.product_name)
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = format("%s-rt", local.product_name)
  }
}

resource "aws_route_table_association" "public-a" {
  subnet_id      = aws_subnet.public-a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-c" {
  subnet_id      = aws_subnet.public-c.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-d" {
  subnet_id      = aws_subnet.public-d.id
  route_table_id = aws_route_table.public.id
}

resource "aws_subnet" "public-a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = format("%sa", var.region)

  tags = {
    Name = format("%s-public-subnet-a", local.product_name)
  }
}

resource "aws_subnet" "public-c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = format("%sc", var.region)

  tags = {
    Name = format("%s-public-subnet-c", local.product_name)
  }
}

resource "aws_subnet" "public-d" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = format("%sd", var.region)

  tags = {
    Name = format("%s-public-subnet-d", local.product_name)
  }
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc-range

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

resource "aws_subnet" "public" {
  count = length(var.public-subnets)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.public-subnets, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = format("%s-public-subnet-%s", local.product_name, count.index)
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.public-subnets)

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_vpc" "fls_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "fls_vpc-dev"
  }
}

resource "aws_subnet" "flc_public_subnet" {
  vpc_id                  = aws_vpc.fls_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "flc_public_subnet-dev"
  }
}

resource "aws_internet_gateway" "fls_igw" {
  vpc_id = aws_vpc.fls_vpc.id

  tags = {
    Name = "fls_igw-dev"
  }
}

resource "aws_route_table" "fls_public_rt" {
  vpc_id = aws_vpc.fls_vpc.id

  tags = {
    Name = "fls_public_rt-dev"
  }
}

resource "aws_route" "fls_default_route" {
  route_table_id         = aws_route_table.fls_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.fls_igw.id
}

resource "aws_route_table_association" "fls_public_rta" {
  subnet_id      = aws_subnet.flc_public_subnet.id
  route_table_id = aws_route_table.fls_public_rt.id
}

resource "aws_security_group" "fls_sg" {
  name        = "fls_sg-dev"
  description = "fls_sg-dev"
  vpc_id      = aws_vpc.fls_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.workstation_ip
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

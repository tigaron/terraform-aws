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

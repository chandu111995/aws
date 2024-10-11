

variable "aws_access_key_id" {
  description = "AWS Access Key ID"
}

variable "aws_secret_access_key" {
  description = "AWS Secret Access Key"
}

provider "aws" {
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  region     = "us-east-1"
}



resource "aws_vpc" "vpc" {

  cidr_block = "10.0.0.0/16"
  tags = {
    name = "firstvpc"
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    name = "firstig"
  }
}

resource "aws_subnet" "public_subnet1" {
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24"
  tags = {
    name = "ps1"
  }
}

resource "aws_subnet" "public_subnet2" {
  availability_zone = "us-east-1b"
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.2.0/24"
  tags = {
    name = "ps2"
  }
}

resource "aws_subnet" "public_subnet3" {
  availability_zone = "us-east-1c"
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.3.0/24"
  tags = {
    name = "ps3"
  }
}

resource "aws_route_table" "prt" {
  vpc_id = aws_vpc.vpc.id
  route {
    gateway_id = aws_internet_gateway.ig.id
    cidr_block = "0.0.0.0/0"
  }
}

resource "aws_route_table_association" "assoc1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.prt.id
}

resource "aws_route_table_association" "assoc2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.prt.id
}

resource "aws_route_table_association" "assoc3" {
  subnet_id      = aws_subnet.public_subnet3.id
  route_table_id = aws_route_table.prt.id
}

# Private Subnet 1
resource "aws_subnet" "private_subnet1" {
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.4.0/24"
  tags = {
    name = "private-ps1"
  }
}

# Private Subnet 2
resource "aws_subnet" "private_subnet2" {
  availability_zone = "us-east-1b"
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.5.0/24"
  tags = {
    name = "private-ps2"
  }
}

# Private Subnet 3
resource "aws_subnet" "private_subnet3" {
  availability_zone = "us-east-1c"
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.6.0/24"
  tags = {
    name = "private-ps3"
  }
}

# Create Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    name = "private-route-table"
  }
}

# Route Table Associations for Private Subnets
resource "aws_route_table_association" "private_assoc1" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_assoc2" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_assoc3" {
  subnet_id      = aws_subnet.private_subnet3.id
  route_table_id = aws_route_table.private_rt.id
}







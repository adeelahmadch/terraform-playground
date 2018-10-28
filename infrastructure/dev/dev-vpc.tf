# Fetch AZs in the current region
data "aws_availability_zones" "available" {}

# Defining VPC for Development Environment
resource "aws_vpc" "vpc-development" {
  cidr_block = "${var.dev-vpc}"

  tags {
    Name = "development"
  }
}

# Defining IGW for the public subnets
resource "aws_internet_gateway" "ig-vpc-development" {
  vpc_id = "${aws_vpc.vpc-development.id}"

  tags {
    Name = "development"
  }
}

# Defining Public Subnet 1
resource "aws_subnet" "public-sub1-development" {
  cidr_block              = "${var.public-sub1-dev-vpc}"
  availability_zone       = "${var.public-sub1-dev-vpc-az}"
  vpc_id                  = "${aws_vpc.vpc-development.id}"
  map_public_ip_on_launch = true

  tags {
    Name = "pub1-subnet-vpc-development"
  }

  depends_on = ["aws_vpc.vpc-development"]
}

# Defining Public Subnet 2
resource "aws_subnet" "public-sub2-development" {
  cidr_block              = "${var.public-sub2-dev-vpc}"
  availability_zone       = "${var.public-sub2-dev-vpc-az}"
  vpc_id                  = "${aws_vpc.vpc-development.id}"
  map_public_ip_on_launch = true

  tags {
    Name = "pub2-subnet-vpc-development"
  }

  depends_on = ["aws_vpc.vpc-development"]
}

# Defining route table for public subnet [12]
resource "aws_route_table" "rt-public-sub12-development" {
  vpc_id = "${aws_vpc.vpc-development.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ig-vpc-development.id}"
  }

  tags {
    Name = "route-table-vpc-public-sub12-development"
  }

  depends_on = ["aws_internet_gateway.ig-vpc-development"]
}

# Defining Route Table Assoication for Public Subnet [12] 
resource "aws_route_table_association" "rt-association-pub1" {
  subnet_id      = "${aws_subnet.public-sub1-development.id}"
  route_table_id = "${aws_route_table.rt-public-sub12-development.id}"
}

resource "aws_route_table_association" "rt-association-pub2" {
  subnet_id      = "${aws_subnet.public-sub2-development.id}"
  route_table_id = "${aws_route_table.rt-public-sub12-development.id}"
}

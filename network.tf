resource "aws_vpc" "main" {
  cidr_block           = "10.0.1.0/24"
  enable_dns_hostnames = true

  tags = {
    Name = local.app_name
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = local.app_name
  }
}

resource "aws_route" "route" {
  route_table_id         = aws_vpc.main.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_subnet" "one" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/28"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "${local.app_name}-main"
  }
}

resource "aws_subnet" "two" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.16/28"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "${local.app_name}-main"
  }
}

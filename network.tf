resource "aws_vpc" "main" {
  cidr_block = "10.0.1.0/24"
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

resource "aws_subnet" "one" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/28"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "${local.app_name}-main"
  }
}

resource "aws_subnet" "two" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.16/28"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "${local.app_name}-main"
  }
}

# data "aws_route_table" "selected" {
#   subnet_id = aws_subnet.one.id
#   depends_on = [
#     aws_subnet.one
#   ]
# }

# resource "aws_route" "route" {
#   route_table_id            = data.aws_route_table.selected.id
#   destination_cidr_block    = "0.0.0.0/0"
#   vpc_peering_connection_id = aws_internet_gateway.gw.id
# }

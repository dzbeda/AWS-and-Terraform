## Public route table - go to internet

resource "aws_route_table" "route-table-public-subnet" {
  vpc_id = aws_vpc.vpc-main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "main"
    env = var.tags_env
  }
}

resource "aws_route_table_association" "public-subnet" {
  count = 2
  route_table_id = aws_route_table.route-table-public-subnet.id
  subnet_id = aws_subnet.public_subnet.*.id[count.index]
}


## Private route table - go to NAT

resource "aws_route_table" "route-table-private-subnet" {
  count = 2
  vpc_id = aws_vpc.vpc-main.id
  tags = {
    Name = "main"
    env = var.tags_env
  }
}

resource "aws_route_table_association" "private-subnet" {
  count = 2
  route_table_id = aws_route_table.route-table-private-subnet.*.id[count.index]
  subnet_id = aws_subnet.private_subnet.*.id[count.index]
}

resource "aws_route" "private" {
  count = 2
  route_table_id = aws_route_table.route-table-private-subnet.*.id[count.index]
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat-gw.*.id[count.index]
}
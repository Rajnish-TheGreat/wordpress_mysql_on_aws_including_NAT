resource "aws_eip" "eip" {
  vpc              = true
  public_ipv4_pool = "amazon"
}


output "new_output" {
  value=  aws_eip.eip
}


resource "aws_nat_gateway" "nat" {
  depends_on=[aws_eip.eip]
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "nat"
  }
}

resource "aws_route_table" "private_route_table" {
  depends_on=[aws_nat_gateway.nat]
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.nat.id}"
  }

  tags = {
    Name = "private_route_table"
  }
}


resource "aws_route_table_association" "private_rt_association" {
  depends_on=[aws_route_table.private_route_table]
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}


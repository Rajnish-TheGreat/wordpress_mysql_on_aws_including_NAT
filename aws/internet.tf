resource "aws_internet_gateway" "int_gate" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name = "web_gate"
  }
}


resource "aws_route_table" "public_route_table" {
  depends_on=[aws_subnet.public_subnet]
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.int_gate.id}"
  }

  tags = {
    Name = "public_route_table"
  }
}


resource "aws_route_table_association" "rt_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}


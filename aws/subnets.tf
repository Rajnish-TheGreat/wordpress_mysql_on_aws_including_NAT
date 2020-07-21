resource "aws_subnet" "public_subnet" {
  depends_on=[aws_vpc.vpc]
  vpc_id     = "${aws_vpc.vpc.id}"
  availability_zone = "ap-south-1a"
  cidr_block = "192.168.0.0/24"
  map_public_ip_on_launch = true


  tags = {

    Name = "public_subnet"
  }
}


resource "aws_subnet" "private_subnet" {
  depends_on=[aws_vpc.vpc]
  vpc_id     = "${aws_vpc.vpc.id}"
  availability_zone = "ap-south-1a"
  cidr_block = "192.168.1.0/24"
  #map_public_ip_on_launch = true


  tags = {

    Name = "private_subnet"
  }
}

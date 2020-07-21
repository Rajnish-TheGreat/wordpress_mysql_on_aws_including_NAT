resource "aws_instance" "wordpress" {
  depends_on=[aws_security_group.public, aws_key_pair.webkey1]
  ami           = "ami-0f37a73ce5f0d08fc"
  instance_type = "t2.micro"
  availability_zone = "ap-south-1a"
  key_name      = "webkey1"
  subnet_id     = "${aws_subnet.public_subnet.id}"
  security_groups = ["${aws_security_group.public.id}"]
  
  tags = {
    Name = "wordpress"
  }
}


resource "aws_instance" "bositon_host" {
  depends_on=[aws_security_group.bositon_ssh, aws_key_pair.webkey1]
  ami           = "ami-0732b62d310b80e97"
  instance_type = "t2.micro"
  subnet_id     = "${aws_subnet.public_subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.bositon_ssh.id}"]
  key_name      = "webkey1"

  tags = {
    Name = "bositon_host"
  }
}


resource "aws_instance" "mysql" {
  depends_on=[aws_security_group.sql_web,aws_security_group.sql_bositon_ssh, aws_key_pair.webkey1]
  ami           = "ami-0415c57c5a21a4d71"
  instance_type = "t2.micro"
  subnet_id= aws_subnet.private_subnet.id 
  vpc_security_group_ids = [aws_security_group.sql_web.id ,aws_security_group.sql_bositon_ssh.id]
  key_name      = "webkey1"

  tags = {
    Name = "mysql"
  }
}


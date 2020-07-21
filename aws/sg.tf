resource "aws_security_group" "public" {
  depends_on=[aws_subnet.public_subnet]
  vpc_id      = "${aws_vpc.vpc.id}"
  name        = "public_subnet"
  description = "public_subnet"

  ingress {
    description = "allow_http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks  = ["::/0"]

  }

  ingress {
    description = "allow_https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks  = ["::/0"]

  }

  ingress {
    description = "allow_ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks  = ["::/0"]

  }

    ingress {
    description = "allow_icmp"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks  = ["::/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks  = ["::/0"]

  }

  tags = {
    Name = "public_subnet"
  }
}


resource "aws_security_group" "bositon_ssh" {
  depends_on=[aws_subnet.public_subnet]
  name        = "bositon_ssh"
  description = "Allow ssh bositon inbound traffic"
  vpc_id      =  aws_vpc.vpc.id

 ingress {
    description = "allow_ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks =  ["::/0"]
  }

 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks =  ["::/0"]
  }

  tags = {
    Name = "bositon_ssh"
  }
}


resource "aws_security_group" "sql_web" {
  depends_on=[aws_subnet.public_subnet]
  name        = "sql_web"
  description = "Allow only sql inbound traffic"
  vpc_id      =  aws_vpc.vpc.id

 ingress {
    description = "mysql_port"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups=[aws_security_group.public.id]
    
  }

  ingress {
    description = "allow_icmp"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    security_groups=[aws_security_group.public.id]
    ipv6_cidr_blocks=["::/0"]
    
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks =  ["::/0"]
  }


  tags = {
    Name = "sql_web"
  }
}


resource "aws_security_group" "sql_bositon_ssh" {
  depends_on=[aws_subnet.public_subnet]
  name        = "only_ssh_sql_bositon"
  description = "Allow ssh only from bositon"
  vpc_id      =  aws_vpc.vpc.id

 ingress {
    description = "allow_ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups=[aws_security_group.bositon_ssh.id]
 
 }

 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks =  ["::/0"]
  }

  tags = {
    Name = "sql_bositon_ssh"
  }
}

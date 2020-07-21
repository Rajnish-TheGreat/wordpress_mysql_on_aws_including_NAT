resource "tls_private_key" "prkey" {
  algorithm  = "RSA"
}


resource "aws_key_pair" "webkey1" {
  key_name   = "webkey1"
  public_key = tls_private_key.prkey.public_key_openssh
}
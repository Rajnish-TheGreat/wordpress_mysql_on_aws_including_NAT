provider "aws" {
  region     = "ap-south-1"
  # profile    = "thegreat"
}

module "aws_code" {
    source = "./aws"
    
}
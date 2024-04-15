resource "aws_vpc" "vpc-virginia" {
  cidr_block = var.virginia_cidr
  tags = {
    Name = "SC"
    env  = "Dev"
  }
}

resource "aws_vpc" "vpc-ohio" {
  cidr_block = var.ohio_cidr
  tags = {
    Name = "SC"
    env  = "Dev"
  }
  provider = aws.ohio
}
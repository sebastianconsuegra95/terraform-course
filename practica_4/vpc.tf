resource "aws_vpc" "vpc-virginia" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "SC"
    env  = "Dev"
  }
}

resource "aws_vpc" "vpc-ohio" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "SC"
    env  = "Dev"
  }
  provider = aws.ohio
}

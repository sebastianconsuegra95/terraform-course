resource "aws_instance" "public_instance" {
  ami           = "ami-051f8a213df8bc089"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = data.aws_key_pair.key.key_name
}

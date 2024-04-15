resource "aws_instance" "public_instance" {
  ami                    = "ami-051f8a213df8bc089"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]


  provisioner "local-exec" {
    command = "echo instancia creada con IP ${aws_instance.public_instance.public_ip} >> datos_instancia.txt"
  }




  # lifecycle {
  #   replace_triggered_by = [
  #     aws_subnet.private_subnet.id
  #   ]
  # }
}

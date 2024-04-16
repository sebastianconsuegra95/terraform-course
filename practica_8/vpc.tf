# Virtual Private Cloud
resource "aws_vpc" "vpc-virginia" {
  cidr_block = var.virginia_cidr
  tags = {
    Name = "vpc_virginia-${local.sufix}"
  }
}

# Subnetwork
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc-virginia.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet-${local.sufix}"
  }
}

# Subnetwork
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc-virginia.id
  cidr_block = var.subnets[1]
  tags = {
    Name = "private_subnet-${local.sufix}"
  }
  depends_on = [aws_subnet.public_subnet]
}

# Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc-virginia.id
  tags = {
    Name = "igw_internet_gateway-${local.sufix}"
  }
}

# Table for VPC
resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc-virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public_crt-${local.sufix}"
  }
}

resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
}

# Security Group 
resource "aws_security_group" "sg_public_instance" {
  name        = "Public Instance SG"
  description = "Allow SSH inbound traffic and ALL egress traffic"
  vpc_id      = aws_vpc.vpc-virginia.id

  dynamic "ingress" {
    for_each = var.ingress_port_list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_ingress_cidr]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

module "mybucket" {
  source      = "./modules/s3"
  bucket_name = local.s3-sufix
}

output "s3_srn" {
  value = module.mybucket.s3_srn
}

# You cannot create a new backend by simply defining this and then
# immediately proceeding to "terraform apply". The S3 backend must
# be bootstrapped according to the simple yet essential procedure in
# https://github.com/cloudposse/terraform-aws-tfstate-backend#usage

# module "terraform_state_backend" {
#   source = "cloudposse/tfstate-backend/aws"
#   # Cloud Posse recommends pinning every module to a specific version
#   version     = "1.4.0"
#   namespace  = "example-sebastianc"
#   stage      = "prod"
#   environment = "us-east-1"
#   name       = "terraform"
#   attributes = ["state"]

#   terraform_backend_config_file_path = "."
#   terraform_backend_config_file_name = "backend.tf"
#   force_destroy                      = false
# }


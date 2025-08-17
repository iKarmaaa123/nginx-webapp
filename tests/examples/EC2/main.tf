// instantiating vpc child module
module "vpcmodule" {
  source = "../vpc"
}

// creating ec2 instance to install nginx on
resource "aws_instance" "webapp" {
  ami           = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = module.vpcmodule.subnet_id
  vpc_security_group_ids = [module.vpcmodule.security_group_ids]

  user_data = var.user_data

  tags = {
    Name = "${var.environment}-nginx-webapp"
  }
}

// retrieving ami id from AWS for ec2 instance
data "aws_ami" "amzlinux2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Amazon
}

// allocating public ip address to ec2 instance
resource "aws_eip" "lb" {
  depends_on = [aws_instance.webapp]
  instance = aws_instance.webapp.id
  domain   = "vpc"
}


resource "aws_instance" "webapp" {
  ami           = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  count = var.ec2_count
  subnet_id = element(var.subnet_ids, count.index)
  vpc_security_group_ids = var.security_group_ids
  user_data = var.user_data

  tags = {
    Name = "${var.environment}-nginx-webapp"
  }
}

data "aws_ami" "amzlinux2" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }

  filter {
    name = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}




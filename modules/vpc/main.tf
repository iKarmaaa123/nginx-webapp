// creating VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "${var.environment}-nginx_vpc"
  }
}

// public subnets
resource "aws_subnet" "public_subnets" {
  count = 2
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = element(var.public_subnet_cidr_block, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.environment}-nginx-public_subnet"
  }
}

resource "aws_subnet" "private_subnets" {
  count = 2
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = element(var.private_subnet_cidr_block, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.environment}-nginx-public_subnet"
  }
}

// security group
resource "aws_security_group" "my_security_group" {
  name        = "dev_security_group"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_vpc.my_vpc.id

  tags = {
    Name = "${var.environment}-nginx-security_group"
  }
}

// security group rule to Accept port 80 requests that will come from the ALB
resource "aws_security_group_rule" "ingress_port_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.my_security_group.id
  cidr_blocks = ["0.0.0.0/0"]
}

// security group rule to allow the instance to accept SSH requests from anywhere
resource "aws_security_group_rule" "ingress_port_22" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.my_security_group.id
}

// enabling the ec2 instance to establish outbound communication with sources situated on the internet
resource "aws_security_group_rule" "egress_port_0" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.my_security_group.id
}

// internet gateway to allow subnets within vpc to send requests to the internet or to accept requests from the internet
resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "${var.environment}-nginx-internet_gateway"
  }
}

resource "aws_nat_gateway" "my_aws_nat_gateway" {
  count = 2
  allocation_id = aws_eip.my_aws_eip[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id

  tags = {
    Name = "${var.environment}-NATGateway"
  }
  depends_on = [aws_internet_gateway.my_internet_gateway]
}

resource "aws_eip" "my_aws_eip" {
  count = 2
  domain   = "vpc"
}

// route table for public subnet to send traffic to the internet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  count = 2

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_internet_gateway.id
  }

  tags = {
    Name = "${var.environment}-nginx-route_table"
  }
}

resource "aws_route_table" "private_route_table" {
  count = 2
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.my_aws_nat_gateway[count.index].id
  }

  tags = {
    Name = "private_route_table"
  }
}

// route table association for public subnets
resource "aws_route_table_association" "my_aws_public_route_table_association" {
  count = 2
  subnet_id     = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table[count.index].id
}

resource "aws_route_table_association" "my_aws_private_route_table_association" {
  count = 2
  subnet_id     = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table[count.index].id
}

module "vpcmodule" {
  source = "../../modules/vpc"
  vpc_cidr_block = var.vpc_cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
  vpc_name = var.vpc_name
  subnet_name = var.subnet_name
  environment = var.environment
  availability_zones = var.availability_zones
}

module "ec2module" {
  source = "../../modules/webapp"
  instance_type = var.instance_type
  ec2_count = var.ec2_count
  eip_count = var.eip_count
  key_name = var.key_name
  environment = var.environment
  user_data = var.user_data
  subnet_ids = module.vpcmodule.subnet_ids
  vpc_id = module.vpcmodule.vpc_id
  security_group_ids = [module.vpcmodule.security_group_ids]
}

// application load balancer
resource "aws_lb" "my_lb" {
  name               = "${var.environment}-nginx-loadbalancer"
  internal           = false
  load_balancer_type = "application"
  subnets            = module.vpcmodule.subnet_ids
  security_groups    = [module.vpcmodule.security_group_ids]
}

// alb target group
resource "aws_lb_target_group" "my_lb_target_group" {
  name     = "${var.environment}-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpcmodule.vpc_id

// health check settings
  health_check {
    enabled = true
    port = "traffic-port"
    interval = 10
    path = "/"
    protocol = "HTTP"
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 2
   }
}

resource "aws_lb_listener" "my_lb_listener-1" {
  load_balancer_arn = aws_lb.my_lb.arn
  port              = 80
  protocol          = "HTTP"

   default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_lb_target_group.arn
  }
}

locals {
  instance_ids = module.ec2module.ec2_instance
}

// alb attachment resource
resource "aws_lb_target_group_attachment" "alb_attachment" {
  count = 2
  target_group_arn = aws_lb_target_group.my_lb_target_group.arn
  target_id        = element(local.instance_ids, count.index)
  port             = 80
}



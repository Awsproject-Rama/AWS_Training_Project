## Getting data from cloudformation - subnetid 
data "aws_cloudformation_export" "PublicSubnetID1" {
  name = "MyVPCStack-PublicSubnetID1"
}
data "aws_cloudformation_export" "PublicSubnetID2" {
  name = "MyVPCStack-PublicSubnetID2"
}

#data "aws_availability_zones" "all" { }
## Security Group for ELB
resource "aws_security_group" "elb_sg" {
  name = "terraform-elb-sg"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
## Creating NLB

  resource "aws_lb_listener" "listener" {
    load_balancer_arn = "${aws_lb.NLB.arn}"
    port              = "8080"
    protocol          = "TCP"
    default_action {
      target_group_arn = "${aws_lb_target_group.lbtg.arn}"
      type             = "forward"
    }
  }
  resource "aws_lb_target_group" "lbtg" {
    name     = "terraform-elb-tg"
    port     = "22"
    protocol = "TCP"
    vpc_id = data.aws_cloudformation_export.VpcID.value
    target_type = "instance"
    deregistration_delay = "100"
    health_check {
      interval = "30"
      port = "22"
      protocol = "TCP"
      healthy_threshold = "2" 
      unhealthy_threshold= "2" 
    }
  }
  resource "aws_lb" "NLB" {
    name = "terraform-asg-instance"
    load_balancer_type = "network"
    subnets = [data.aws_cloudformation_export.PublicSubnetID1.value,data.aws_cloudformation_export.PublicSubnetID2.value ]
    enable_cross_zone_load_balancing = true
  }

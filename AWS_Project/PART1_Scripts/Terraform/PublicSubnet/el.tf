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
## Creating ELB
resource "aws_elb" "ELB" {
  name = "terraform-asg-instance"
  subnets = [data.aws_cloudformation_export.PublicSubnetID1.value,data.aws_cloudformation_export.PublicSubnetID2.value ]
  #availability_zones = ["${data.aws_availability_zones.all.names}"]
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:8080/"
  }
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "8080"
    instance_protocol = "http"
  }
}
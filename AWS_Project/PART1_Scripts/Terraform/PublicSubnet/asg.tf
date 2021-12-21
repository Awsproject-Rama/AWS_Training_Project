
resource "aws_autoscaling_group" "asg" {
  launch_configuration = aws_launch_configuration.LC.name
  min_size = 2
  max_size = 5
  desired_capacity = 2
  health_check_grace_period = 300
  load_balancers = ["${aws_elb.ELB.id}"]
  health_check_type = "EC2"
  vpc_zone_identifier = aws_elb.ELB.subnets
  
  
}


resource "aws_autoscaling_group" "asg" {
  launch_configuration = aws_launch_configuration.LC.name
  min_size = 2
  max_size = 5
  desired_capacity = 2
  health_check_grace_period = 300
  #load_balancers = ["${aws_lb.NLB.id}"]
  health_check_type = "EC2"
  vpc_zone_identifier = aws_lb.NLB.subnets
  target_group_arns = [aws_lb_target_group.lbtg.arn] 
}

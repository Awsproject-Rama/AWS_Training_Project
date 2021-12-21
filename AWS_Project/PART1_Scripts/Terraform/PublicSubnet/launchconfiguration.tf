resource "aws_launch_configuration" "LC" {
  image_id               = "${var.aws_ami}"
  instance_type          = "t2.micro"
  security_groups        = ["${aws_security_group.SG.id}"]
  associate_public_ip_address = true
  key_name               = "${var.keyname}"
  lifecycle {
    create_before_destroy = true
  }
}
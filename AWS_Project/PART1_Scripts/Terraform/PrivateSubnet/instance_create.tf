data "aws_cloudformation_export" "PrivateSubnetID" {
  name = "MyVPCStack-PrivateSubnetID"
}
resource "aws_instance" "linuxvm" {
    instance_type ="t2.micro"
    key_name = "${var.keyname}"
    count = "${var.count_instance}"
    ami = "${var.aws_ami}"
    subnet_id = data.aws_cloudformation_export.PrivateSubnetID.value
    security_groups = "${[aws_security_group.privateSG.id]}"
    tags = {
    Name = "LinuxVM_Privatesubnet"
    }
}
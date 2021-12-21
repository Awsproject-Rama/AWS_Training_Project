variable "count_instance" {
    default = 1
}
variable "keyname" {
    type = string
    default="linvmkp"
}
variable "aws_region" {    
    default = "us-east-1"
}
variable "aws_vpc" {
    type = string
    default = "10.0.0.0/16"
}
variable "aws_ami" {
    type = string
    default = "ami-0e472ba40eb589f49"
}
variable "availabilityzone" {
    type = string
    default = "us-east-1b"
}
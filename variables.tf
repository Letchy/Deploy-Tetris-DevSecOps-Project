variable "vpc-name" {}
variable "igw-name" {}
variable "rt-name" {}
variable "subnet-name" {}
variable "sg-name" {}
variable "instance-name" {}
# variable "key-name" {}
variable "iam-role" {}

variable "aws_region" {
  default = "eu-west-2"
  type    = string
}

variable "ami_id" {
  default = "ami-0acc77abdfc7ed5a6"
  type    = string
}

variable "instance_type" {
  default = "t2.micro"
  type    = string
}

variable "key_name" {
  default = "bkletch-tetris-eu-west-2"
  type    = string
}

variable "bucket" {
  default = "bkletch-tetris-s3"
  type    = string
}

variable "acl" {
  default = "private"
  type    = string
}

variable "region" {
  default     = "us-east-1"
  description = "The AWS region for infrastructure, default value is us-east-1"
}

variable "profile" {
  default     = "devops-test"
  description = "AWS cli profile, this can be set in your user home directory /home/user/.aws/credentials based on different Ooperating systems."
}

variable "dev-vpc" {
  default     = "172.16.0.0/16"
  description = "VPC for Development Environment"
}

variable "public-sub1-dev-vpc" {
  default     = "172.16.248.0/22"
  description = "Public Subnet 1 , Usable Range : 172.16.248.1 - 172.16.251.254"
}

variable "public-sub1-dev-vpc-az" {
  default     = "us-east-1a"
  description = "Availability Zone for Public Subnet 1"
}

variable "public-sub2-dev-vpc" {
  default     = "172.16.252.0/22"
  description = "Public Subnet 2, Usable Range : 172.16.252.1 - 172.16.255.254"
}

variable "public-sub2-dev-vpc-az" {
  default     = "us-east-1b"
  description = "Availability Zone for Public Subnet 2"
}

variable "webserver_port" {
  default     = "80"
  description = "Web Server Port"
}

variable "webserver_protocol" {
  default     = "tcp"
  description = "Web Server Porotocol"
}

variable "alb_port" {
  default     = "80"
  description = "Web Server Port"
}

variable "alb_protocol" {
  default     = "tcp"
  description = "Web Server Porotocol"
}

variable "amazonlinux_ami" {
  type        = "map"
  description = "Amazon AMI Image available in us-east-1"

  default = {
    "us-east-1" = "ami-0922553b7b0369273"
  }
}

variable "instance_type" {
  description = "The EC2 instance type to be used"
  default     = "t2.micro"
}

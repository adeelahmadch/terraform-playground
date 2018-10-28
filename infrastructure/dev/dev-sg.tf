# Security Group for ALB Web Servers
resource "aws_security_group" "sg-alb-public-development" {
  name        = "alb-public-development"
  description = "This security group controls traffic for alb"
  vpc_id      = "${aws_vpc.vpc-development.id}"

  ingress {
    protocol    = "${var.alb_protocol}"
    from_port   = "${var.alb_port}"
    to_port     = "${var.alb_port}"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  depends_on = ["aws_vpc.vpc-development"]
}

# Security Group for Web Servers which only allows traffic from Load Balancer. 
resource "aws_security_group" "webserver-development" {
  name        = "webserver-public-development"
  description = "allow inbound access from the ALB only"

  vpc_id = "${aws_vpc.vpc-development.id}"

  ingress {
    protocol        = "${var.webserver_protocol}"
    from_port       = "${var.webserver_port}"
    to_port         = "${var.webserver_port}"
    security_groups = ["${aws_security_group.sg-alb-public-development.id}"]
    description     = "Allowing Web Port from ALB Only"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allowing SSH Access from Public"
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  depends_on = ["aws_security_group.sg-alb-public-development"]
}

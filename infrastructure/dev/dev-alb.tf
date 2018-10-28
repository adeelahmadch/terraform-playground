### Defining ALB for Web Server

resource "aws_alb" "alb-public-development" {
  name = "alb-webserver-development"

  subnets = [
    "${aws_subnet.public-sub1-development.id}",
    "${aws_subnet.public-sub2-development.id}",
  ]

  security_groups = ["${aws_security_group.sg-alb-public-development.id}"]

  depends_on = ["aws_security_group.sg-alb-public-development"]
}

### Defining Target Group for ALB Web Server

resource "aws_alb_target_group" "tg-alb-public-development" {
  name        = "tg-alb-webserver-development"
  port        = "${var.alb_port}"
  protocol    = "HTTP"
  vpc_id      = "${aws_vpc.vpc-development.id}"
  target_type = "instance"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    port                = 80
    protocol            = "HTTP"
    interval            = 30
  }

  depends_on = ["aws_vpc.vpc-development"]
}

# Configuring listener for ALB
resource "aws_alb_listener" "alb-listener-webserver" {
  load_balancer_arn = "${aws_alb.alb-public-development.id}"
  port              = "${var.alb_port}"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.tg-alb-public-development.id}"
    type             = "forward"
  }
}

# Attaching Target Group to Web Server
resource "aws_lb_target_group_attachment" "webserver1-development" {
  target_group_arn = "${aws_alb_target_group.tg-alb-public-development.arn}"
  target_id        = "${aws_instance.webserver-1.id}"
  port             = 80

  depends_on = ["aws_vpc.vpc-development", "aws_instance.webserver-1"]
}

resource "aws_lb_target_group_attachment" "webserver2-development" {
  target_group_arn = "${aws_alb_target_group.tg-alb-public-development.arn}"
  target_id        = "${aws_instance.webserver-2.id}"
  port             = 80

  depends_on = ["aws_vpc.vpc-development", "aws_instance.webserver-2"]
}

# ran into a bug, as terraform does not allow multuple instance id in target_id. have to write seperate resource for attachment. 


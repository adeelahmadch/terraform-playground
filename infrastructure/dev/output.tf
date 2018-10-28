output "alb_webserver" {
  value = "${element(concat(aws_alb.alb-public-development.*.dns_name, list("")), 0)}"
}

output "webserver1-public" {
  value = "${aws_instance.webserver-1.public_ip}"
}

output "webserver2-public" {
  value = "${aws_instance.webserver-2.public_ip}"
}

#output "instance_ips" {
#  value = ["${aws_instance.web.*.public_ip}"]
#}


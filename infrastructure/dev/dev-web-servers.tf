# Defining Web Server 1
resource "aws_instance" "webserver-1" {
  ami                    = "${var.amazonlinux_ami["us-east-1"]}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${aws_subnet.public-sub1-development.id}"
  key_name               = "${aws_key_pair.devops-test.key_name}"
  vpc_security_group_ids = ["${aws_security_group.webserver-development.id}"]

  connection {
    type = "ssh"
    user = "ec2-user"

    private_key = "${file("./ssh_keypair_files/devops-test")}"
  }

  provisioner "file" {
    source      = "./simple_html_app/index.html"
    destination = "/home/ec2-user/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install nginx1.12 -y",
      "sudo cp -r /home/ec2-user/index.html /usr/share/nginx/html/index.html",
      "sudo service nginx restart",
    ]
  }

  tags {
    Name = "dev-web-1"
  }

  depends_on = ["aws_vpc.vpc-development"]
}

# Defining Web Server 2
resource "aws_instance" "webserver-2" {
  ami                    = "${var.amazonlinux_ami["us-east-1"]}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${aws_subnet.public-sub2-development.id}"
  key_name               = "${aws_key_pair.devops-test.key_name}"
  vpc_security_group_ids = ["${aws_security_group.webserver-development.id}"]

  connection {
    type = "ssh"
    user = "ec2-user"

    private_key = "${file("./ssh_keypair_files/devops-test")}"
  }

  provisioner "file" {
    source      = "./simple_html_app/index.html"
    destination = "/home/ec2-user/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install nginx1.12 -y",
      "sudo cp -r /home/ec2-user/index.html /usr/share/nginx/html/index.html",
      "sudo service nginx restart",
    ]
  }

  tags {
    Name = "dev-web-2"
  }

  depends_on = ["aws_vpc.vpc-development"]
}

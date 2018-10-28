resource "aws_key_pair" "devops-test" {
  key_name   = "devops-test"
  public_key = "${file("./ssh_keypair_files/devops-test.pub")}"
}

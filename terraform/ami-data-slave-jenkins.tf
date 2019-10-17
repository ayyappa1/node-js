
data "aws_ami" "jenkins-slave" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "name"
    values = ["jenkins-slave"]
  }
}

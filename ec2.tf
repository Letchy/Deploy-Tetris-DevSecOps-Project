resource "aws_instance" "jenkins-ec2" {
  ami                    = "ami-0acc77abdfc7ed5a6"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.jenkins_sg01.id]
  user_data              = file("install-tools.sh")

  tags = {
    Name = "Deploy-Tetris-DevSecOps-Project"
  }
}

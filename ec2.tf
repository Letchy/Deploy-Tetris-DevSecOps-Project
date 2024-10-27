/* resource "aws_instance" "jenkins-ec2" {
  ami                    = "ami-0acc77abdfc7ed5a6"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.jenkins-tetris-server
  vpc_security_group_ids = [aws_security_group.jenkins_sg01.id]
  user_data              = file("install-tools.sh")

  tags = {
    Name = "Deploy-Tetris-DevSecOps-Project"
  }
} */

data "aws_key_pair" "jenkins_tetris_server" {
  key_name = "jenkins-tetris-server"
}

resource "aws_instance" "jenkins_ec2" {
  ami           = "ami-0acc77abdfc7ed5a6"
  instance_type = "t2.micro"
  key_name      = data.aws_key_pair.jenkins_tetris_server.key_name

  vpc_security_group_ids = [aws_security_group.jenkins_sg01.id]
  user_data              = templatefile("./install-tools.sh", {})

  tags = {
    Name = "Deploy-Tetris-DevSecOps-Project"
  }
}

data "aws_key_pair" "jenkins_tetris_server" {
  key_name = "jenkins-tetris-server-ubuntu"
}

resource "aws_instance" "jenkins_ec2" {
  /* ami           = "ami-0acc77abdfc7ed5a6" # Amazon Linux 2 */
  ami           = "ami-0e8d228ad90af673b" # Ubuntu Server 24.04 LTS (HVM), SSD Volume Type
  instance_type = "t2.micro"

  key_name = data.aws_key_pair.jenkins_tetris_server.key_name

  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  user_data              = templatefile("./install-tools.sh", {})

  tags = {
    Name = "Deploy-Tetris-DevSecOps-Project"
  }
}

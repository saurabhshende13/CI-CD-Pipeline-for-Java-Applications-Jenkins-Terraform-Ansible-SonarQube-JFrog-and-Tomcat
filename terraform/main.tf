resource "aws_instance" "jenkins_server" {
  for_each = { for k, v in var.instance_names : k => v if k == "jenkins" }
  ami                = var.ami
  instance_type      = var.instance_type
  key_name           = var.key_name
  availability_zone  = var.availability_zone
  subnet_id          = aws_subnet.mysubnet.id
  tags = {
    Name = each.value
  }
  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt install -y openjdk-17-jdk
    sudo apt install -y ansible
    sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
    echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y jenkins
    sudo systemctl start jenkins
    sudo systemctl enable jenkins
  EOF
  vpc_security_group_ids = [
    each.key == "jenkins" ? aws_security_group.jenkins_sg.id :
    aws_security_group.tomcat_sg.id
  ]
}


resource "aws_instance" "other_servers" {
  for_each = { for k, v in var.instance_names : k => v if k != "jenkins" }
  ami                = var.ami
  instance_type      = var.instance_type
  key_name           = var.key_name
  availability_zone  = var.availability_zone
  subnet_id          = aws_subnet.mysubnet.id
  tags = {
    Name = each.value
  }

  vpc_security_group_ids = [
    each.key == "sonarqube"   ? aws_security_group.sonarqube_sg.id :
    each.key == "artifactory" ? aws_security_group.artifactory_sg.id :
    aws_security_group.tomcat_sg.id
  ]
}

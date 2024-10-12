variable "ami" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "subnet_cidr_block" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "instance_names" {
  default = {
    jenkins     = "jenkins-server"
    sonarqube   = "sonarqube-server"
    artifactory = "artifactory-server"
    tomcat      = "tomcat-server"
  }
}

variable "jenkins_ports" {
  description = "List of ports to allow for Jenkins"
  type        = list(number)
}

variable "sonarqube_ports" {
  description = "List of ports to allow for SonarQube"
  type        = list(number)
}

variable "artifactory_ports" {
  description = "List of ports to allow for Artifactory"
  type        = list(number)
}

variable "tomcat_ports" {
  description = "List of ports to allow for Tomcat"
  type        = list(number)
}

variable "cidr_blocks" {
  description = "CIDR blocks allowed for all services"
  type        = list(string)
}

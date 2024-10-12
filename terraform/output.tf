output "instance_ips_jenkins" {
  value = {
    for instance in aws_instance.jenkins_server :
    instance.tags["Name"] => {
      public_ip  = instance.public_ip
      private_ip = instance.private_ip
    }
  }
  description = "Public and Private IP addresses of all EC2 instances"
}

output "instance_ips_other" {
  value = {
    for instance in aws_instance.other_servers :
    instance.tags["Name"] => {
      public_ip  = instance.public_ip
      private_ip = instance.private_ip
    }
  }
  description = "Public and Private IP addresses of all EC2 instances"
}
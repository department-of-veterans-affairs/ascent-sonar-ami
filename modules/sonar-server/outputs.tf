output "sonar_private_ip" {
  value = "${aws_instance.sonar.private_ip}"
}

output "sonar_port" {
  value = "${module.security_group_rules.sonar_port}"
}

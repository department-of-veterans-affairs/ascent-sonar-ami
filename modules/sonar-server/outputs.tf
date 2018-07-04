output "sonar_private_ip" {
  value = "${aws_instance.sonar.private_ip}"
}

output "sonar_port" {
  value = "${module.security_group_rules.sonar_port}"
}

output "security_group_id" {
  value = "${aws_security_group.sonar_security_group.id}"
}

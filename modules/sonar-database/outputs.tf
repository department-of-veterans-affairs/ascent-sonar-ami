output "port" {
  value = "${aws_db_instance.sonar_database_instance.port}"
}

output "endpoint" {
  value = "${aws_db_instance.sonar_database_instance.endpoint}"
}

output "security_group_id" {
  value = "${aws_security_group.sonar_database_security_group.id}"
}

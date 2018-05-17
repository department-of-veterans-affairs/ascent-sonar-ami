# ---------------------------------------------------------------------------------------------------------------------
# THESE TEMPLATES REQUIRE TERRAFORM VERSION 0.8 AND ABOVE
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.9.3"
}


# ---------------------------------------------------------------------------------------------------------------------
# Create the Sonar instance
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_instance" "sonar" {
  instance_type               = "${var.instance_type}"
  ami                         = "${var.ami_id}"
  key_name                    = "${var.ssh_key_name}"
  subnet_id                   = "${var.subnet_ids[length(var.subnet_ids) - 1]}"
  vpc_security_group_ids      = ["${aws_security_group.sonar_security_group.id}"]
  user_data                   = "${var.user_data == "" ? data.template_file.sonar_user_data.rendered : var.user_data}"
  tags {
      Name = "${var.instance_name}"
      SAN = "${var.san}"
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# Control Traffic to Sonar instances
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "sonar_security_group" {
  name_prefix = "${var.instance_name}"
  description = "Security group for the ${var.instance_name} instances"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name = "${var.instance_name}"
  }
}

module "security_group_rules" {
  source = "../sonar-security-group-rules"

  security_group_id                  = "${aws_security_group.sonar_security_group.id}"
  allowed_inbound_cidr_blocks        = ["${var.allowed_inbound_cidr_blocks}"]
  allowed_inbound_security_group_ids = ["${var.allowed_inbound_security_group_ids}"]
  allowed_ssh_cidr_blocks            = ["${var.allowed_ssh_cidr_blocks}"]
  sonar_port                       = "${var.sonar_http_port}"
}


# ---------------------------------------------------------------------------------------------------------------------
# Default User Data script
# ---------------------------------------------------------------------------------------------------------------------
data "template_file" "sonar_user_data" {
  template = "${file("${path.module}/sonar-user-data.sh")}"

  vars {
    jdbc_url            = "jdbc:postgresql://${module.sonar-database.endpoint}/${var.sonar_db_name}"
    sonar_db_username         = "${var.sonar_db_username}"
    sonar_db_password         = "${var.sonar_db_password}"
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# The Database for Sonar to Use
# ---------------------------------------------------------------------------------------------------------------------

module "sonar-database" {
  source                               = "../sonar-database"
  sonar_db_username                  = "${var.sonar_db_username}"
  sonar_db_password                  = "${var.sonar_db_password}"
  root_db_name                         = "${var.root_db_name}"
  sonar_db_identifier                = "${var.instance_name}-database"
  sonar_subnet_ids                   = ["${var.subnet_ids}"]
  allowed_inbound_security_group_id    = "${aws_security_group.sonar_security_group.id}"
  vpc_id                               = "${var.vpc_id}"
}

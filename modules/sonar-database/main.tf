# ---------------------------------------------------------------------------------------------------------------------
# THESE TEMPLATES REQUIRE TERRAFORM VERSION 0.8 AND ABOVE
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.9.3"
}


# ---------------------------------------------------------------------------------------------------------------------
# CREATE A DATABASE INSTANCE
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_db_instance" "sonar_database_instance" {
  allocated_storage      = 20
  identifier             = "${var.sonar_db_identifier}"
  instance_class         = "db.r3.large"
  engine                 = "postgres"
  engine_version         = "${var.postgres_version}"
  username               = "${var.sonar_db_username}"
  password               = "${var.sonar_db_password}"
  name                   = "${var.root_db_name}"
  vpc_security_group_ids = ["${aws_security_group.sonar_database_security_group.id}"]
  db_subnet_group_name   = "${aws_db_subnet_group.sonar_subnet_group.id}"
  # TODO: may need to change this later. Leave true for now for
  #    testing purposes
  skip_final_snapshot    = true
}

resource "aws_db_subnet_group" "sonar_subnet_group" {
  name                   = "${var.sonar_db_identifier}-subnet_group"
  subnet_ids             = ["${var.sonar_subnet_ids}"]

  tags {
    Name                 = "DB subnet group for ${var.sonar_db_identifier}"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A SECURITY GROUP FOR THE INSTANCE
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_security_group" "sonar_database_security_group" {
  name_prefix            = "${var.sonar_db_identifier}-security_group"
  description            = "Security group for the ${var.sonar_db_identifier} db instance"
  vpc_id                 = "${var.vpc_id}"
  tags {
     Name  = "${var.sonar_db_identifier}"
  }
}

module "security_group_rules" {
  source = "../rds-security-group-rules"
  security_group_id                             = "${aws_security_group.sonar_database_security_group.id}"
  allowed_inbound_security_group_id             = "${var.allowed_inbound_security_group_id}"
}

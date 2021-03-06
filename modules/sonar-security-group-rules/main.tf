###############################################################################
#
# Create Security group for Fortify services
#
###############################################################################

resource "aws_security_group_rule" "allow_sonar_web_inbound" {
  type        = "ingress"
  from_port   = "${var.sonar_port}"
  to_port     = "${var.sonar_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_cidr_blocks}"]

  security_group_id = "${var.security_group_id}"
}

resource "aws_security_group_rule" "allow_sonar_ssh_inbound" {
  type        = "ingress"
  from_port   = "${var.ssh_port}"
  to_port     = "${var.ssh_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_cidr_blocks}"]

  security_group_id = "${var.security_group_id}"
}

resource "aws_security_group_rule" "allow_sonar_tcp_inbound_from_security_group_ids" {
  count                    = "${length(var.allowed_inbound_security_group_ids)}"
  type                     = "ingress"
  from_port                = "${var.sonar_port}"
  to_port                  = "${var.sonar_port}"
  protocol                 = "tcp"
  source_security_group_id = "${element(var.allowed_inbound_security_group_ids, count.index)}"
  security_group_id        = "${var.security_group_id}"
}

resource "aws_security_group_rule" "allow_sonar_tcp_inbound_from_db_security_group_id" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = "${var.db_security_group_id}"
  security_group_id        = "${var.security_group_id}"
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${var.security_group_id}"
}

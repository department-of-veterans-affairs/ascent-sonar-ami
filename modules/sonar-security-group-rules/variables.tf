###############################################################################
# REQUIRED VARIABLES
###############################################################################

variable "security_group_id" {
  description = "The ID of the security group to which we allow sonar web access"
}

variable "allowed_inbound_cidr_blocks" {
  description = "A list of CIDR-formatted IP address ranges from which the EC2 Instances will allow connections to Sonar"
  type        = "list"
}

variable "allowed_ssh_cidr_blocks" {
  description = "A list of CIDR-formatted IP address ranges from which the EC2 Instances will allow connections to Sonar"
  type        = "list"
}

###############################################################################
# OPTIONAL VARIABLES
###############################################################################

variable "allowed_inbound_security_group_ids" {
  description = "A list of security group IDs that will be allowed to connect to Sonar"
  type        = "list"
  default     = []
}

variable "sonar_port" {
  description = "The port used to resolve sonar web connections"
  default     = 5432
}


variable "ssh_port" {
  description = "The port used to resolve SSH connections"
  default     = 22
}

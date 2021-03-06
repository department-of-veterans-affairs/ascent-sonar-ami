###############################################################################
# REQUIRED VARIABLES
###############################################################################

variable "security_group_id" {
  description = "The ID of the sonar instance security group to which we will allow access"
}

variable "allowed_inbound_security_group_id" {
  description = "The sonar instance's security group ID"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------
variable "db_connection_port" {
  description = "The port for db connections"
  default     = "5432"
}

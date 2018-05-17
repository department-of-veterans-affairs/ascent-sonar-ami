
# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "instance_name" {
  description = "The name of the sonar instance. This variable is used to namespace all resources created by this module."
}

variable "ami_id" {
  description = "The ID of the AMI to run in this cluster."
}

variable "instance_type" {
  description = "The type of EC2 Instances to run for the sonar instance (e.g. m4.large)"
}

variable "vpc_id" {
  description = "The ID of the VPC in which to deploy the sonar instance"
}

variable "allowed_inbound_cidr_blocks" {
  description = "A list of CIDR-formatted IP address ranges from which the EC2 Instances will allow connectiont to DNS"
  type        = "list"
}

variable "subnet_ids" {
  description = "The subnet IDs into which the EC2 instances should be deployed."
  type        = "list"
}

variable "sonar_db_username" {
  description = "The database username with which to authenticate"
}

variable "sonar_db_password" {
  description = "The database password with which to authenticate"
}


# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "san" {
  description = "The value for the SAN tag of the instance"
  default     = "sonar.internal.vetservices.gov"
}

variable "root_db_name" {
  description = "The name of the database created by rds on when it first comes up"
  default     = "rootdb"
}
variable "sonar_db_name" {
  description = "The name of the database that fortify will use"
  default     = "postgres"
}

variable "postgres_version" {
  description = "The version of the mysql database engine"
  default     = "9.6.6"
}

variable "user_data" {
  description = "A User data script to execute while the server is booting."
  default     = ""
}

variable "ssh_key_name" {
  description  = "The name of an EC2 Key Pair that can be used to SSH to the EC2 Instance. Set to an empty string to not associate a key pair"
  default      = ""
}

variable "allowed_ssh_cidr_blocks" {
  description = "A list of CIDR-formatted IP address ranges from which the EC2 Instances will allow SSH connections"
  type        = "list"
  default     = []
}

variable "allowed_ssh_security_group_ids" {
  description = "A list of security group IDs from which the EC2 Instance will allow SSH connections."
  type        = "list"
  default     = []
}

variable "allowed_inbound_security_group_ids" {
  description = "A list of security group IDs that will be allowed to connect to Sonar"
  type        = "list"
  default     = []
}

variable "associate_public_ip_address" {
  description = "If set to true, associate a public IP address with the Sonar instance"
  default     = false
}

variable "spot_price" {
  description = "The maximum hourly price to pay for EC2 spot Instances."
  default     = ""
}

variable "tenancy" {
  description = "The tenancy of the instance. Must be one of: empty string, default, or dedicated. For EC2 Spot Instances only empty string or dedicated can be used."
  default     = ""
}

variable "root_volume_ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized."
  default     = false
}

variable "root_volume_type" {
  description = "The type of volume. Must be one of: standard, gp2, or io1."
  default     = "standard"
}

variable "root_volume_size" {
  description = "The size, in GB, of the root EBS volume."
  default     = 20
}

variable "root_volume_delete_on_termination" {
  description = "Whether the volume should be destroyed on instance termination"
  default     = "true"
}

variable "sonar_http_port" {
  description = "The port used to reach fortify's UI console"
  default     = 9000
}

variable "ssh_port" {
  description = "The port used for SSH connections"
  default     = 22
}

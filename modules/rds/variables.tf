variable "default_tags" {
  type = map(any)
  default = {
    Environment = "Prod"
    AppName     = "WebApp"
    Team        = "DevOps"
    ManagedBy   = "Terraform"
  }
}

variable "rds_storage" {
  default = 50
}

variable "rds_version" {
  default = "11.5"
}

variable "rds_instance_class" {
  default = "db.m5.large"
}

variable "default_db" {
  default = "prod"
}

variable "default_admin_user" {
  default = "pr_admin"
}

variable "default_admin_password" {
  default = "password"
}

variable "private_subnets_cidr" {
  type = list(any)
}

variable "vpc_id" {
}

variable "multi_az" {
  default = true
}

variable "private_subnet_id" {
  type = list(any)
}

variable "availability_zones" {
  type    = list(any)
  default = ["us-east-2a", "us-east-2b"]
}

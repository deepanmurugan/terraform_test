variable "default_tags" {
  type = map(any)
  default = {
    Environment = "Prod"
    AppName     = "WebApp"
    Team        = "DevOps"
    ManagedBy   = "Terraform"
  }
}

variable "cluster_name" {
  default = "Prod-EKS"
}

variable "cluster_version" {
  default = "1.21"
}

variable "ng_ami_type" {
  default = "AL2_x86_64"
}

variable "ng_disk_size" {
  default = "20"
}

variable "ng_instance_types" {
  default = "t3.small"
}

variable "ng_min_size" {
  default = 2
}

variable "ng_max_size" {
  default = 8
}

variable "ng_desired_size" {
  default = 2
}

variable "cluster_enabled_log_types" {
  default = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "vpc_id" {
}

variable "private_subnet_id" {
  type    = list(any)
  default = []
}

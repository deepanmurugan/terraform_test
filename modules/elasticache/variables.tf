variable "default_tags" {
  type = map(any)
  default = {
    Environment = "Prod"
    AppName     = "WebApp"
    Team        = "DevOps"
    ManagedBy   = "Terraform"
  }
}

variable "availability_zones" {
  type    = list(any)
  default = ["us-east-2a", "us-east-2b"]
}

variable "redis_node_type" {
  default = "cache.m5.large"
}

variable "redis_engine_version" {
  default = "5.0.6"
}

variable "private_subnet_id" {
  type = list(any)
}

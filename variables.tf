variable "default_tags" {
  type = map(any)
  default = {
    Environment = "Prod"
    AppName     = "WebApp"
    Team        = "DevOps"
    ManagedBy   = "Terraform"
  }
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "The CIDR block of the vpc"
}

variable "availability_zones" {
  type    = list(any)
}

variable "public_subnets_cidr" {
  type    = list(any)
}

variable "private_subnets_cidr" {
  type    = list(any)
}

variable "private_subnet_count" {
  type    = number
}

variable "public_subnet_count" {
  type    = number
}

#Instance module variables
variable "instance_type" {
}

variable "volume_size" {
}

variable "volume_type" {
}

variable "private_subnet_id" {
  type    = list(any)
  default = []
}

variable "public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0HRMBDzuqjLm2wNo7f4qcfK54nBPPPHmFNjtEF3O9lymqcVMPRrEvClmefTQ4WQXFduI5EYbxncdBRDzCQCv9dbMFBcPJ/4Q8eW8JustPvT0marPMoBkgwO2skWISHHQAJa014FdfDpqx4vrwr9Rp3DRSJWJgvqZBk85EnkrsocluLSoCC7zs80NI44zoVG7ENFzSLbSxc8nCSecK+gmGST7O3checM5kR98Xao2HhtnCi8K8wk6oQza9JczI1fMShUzFA43wDR9KBlstIA+TuZs9iTFXen3tsHpw5OS7569xaF8lis25YLgolLgKHpPYCvvDgLJMb06YpZ8/NS0HrTXXMYFbAT3AGjknOuNDIqkpVHjv1sxfG7HLo7mFEzG+mcGeedViYn225kW2P5/7xqUQod8h+yIWhW4Ei9tyXI0RxrOLYDFQEYfJiGEikiyBlfEJRY0xc26tzNiF+K/0U2FxUNOsrWQL58IG6lZ+kP8rKXlxDPVR7tj2/icU+Ac= deepabi@DeepAbis-MacBook-Air.local"
}

# EKS Module variables
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

#RDS Module vars
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

variable "multi_az" {
  default = true
}

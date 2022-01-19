variable "default_tags" {
  type = map(any)
  default = {
    Environment = "Prod"
    AppName     = "WebApp"
    Team        = "DevOps"
    ManagedBy   = "Terraform"
  }
}

variable "instance_type" {
  default = "t2.micro"
}

variable "volume_size" {
  default = 8
}

variable "volume_type" {
  default = "gp2"
}

variable "public_subnet_id" {
  type    = list(any)
  default = []
}

variable "public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0HRMBDzuqjLm2wNo7f4qcfK54nBPPPHmFNjtEF3O9lymqcVMPRrEvClmefTQ4WQXFduI5EYbxncdBRDzCQCv9dbMFBcPJ/4Q8eW8JustPvT0marPMoBkgwO2skWISHHQAJa014FdfDpqx4vrwr9Rp3DRSJWJgvqZBk85EnkrsocluLSoCC7zs80NI44zoVG7ENFzSLbSxc8nCSecK+gmGST7O3checM5kR98Xao2HhtnCi8K8wk6oQza9JczI1fMShUzFA43wDR9KBlstIA+TuZs9iTFXen3tsHpw5OS7569xaF8lis25YLgolLgKHpPYCvvDgLJMb06YpZ8/NS0HrTXXMYFbAT3AGjknOuNDIqkpVHjv1sxfG7HLo7mFEzG+mcGeedViYn225kW2P5/7xqUQod8h+yIWhW4Ei9tyXI0RxrOLYDFQEYfJiGEikiyBlfEJRY0xc26tzNiF+K/0U2FxUNOsrWQL58IG6lZ+kP8rKXlxDPVR7tj2/icU+Ac= deepabi@DeepAbis-MacBook-Air.local"
}

variable "vpc_id" {
}
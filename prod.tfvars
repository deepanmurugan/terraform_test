# Networking module variables
# ---------------------------
vpc_cidr             = "10.0.0.0/16"
public_subnet_count  = 2
private_subnet_count = 2
public_subnets_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets_cidr = ["10.0.10.0/24", "10.0.11.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]

# Instance Module Variables
# -------------------------
instance_type           = "t2.micro"
volume_size             = "8"
volume_type             = "gp2"
public_key              = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0HRMBDzuqjLm2wNo7f4qcfK54nBPPPHmFNjtEF3O9lymqcVMPRrEvClmefTQ4WQXFduI5EYbxncdBRDzCQCv9dbMFBcPJ/4Q8eW8JustPvT0marPMoBkgwO2skWISHHQAJa014FdfDpqx4vrwr9Rp3DRSJWJgvqZBk85EnkrsocluLSoCC7zs80NI44zoVG7ENFzSLbSxc8nCSecK+gmGST7O3checM5kR98Xao2HhtnCi8K8wk6oQza9JczI1fMShUzFA43wDR9KBlstIA+TuZs9iTFXen3tsHpw5OS7569xaF8lis25YLgolLgKHpPYCvvDgLJMb06YpZ8/NS0HrTXXMYFbAT3AGjknOuNDIqkpVHjv1sxfG7HLo7mFEzG+mcGeedViYn225kW2P5/7xqUQod8h+yIWhW4Ei9tyXI0RxrOLYDFQEYfJiGEikiyBlfEJRY0xc26tzNiF+K/0U2FxUNOsrWQL58IG6lZ+kP8rKXlxDPVR7tj2/icU+Ac= deepabi@DeepAbis-MacBook-Air.local"

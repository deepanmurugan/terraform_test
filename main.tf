module "networking" {
  default_tags           = var.default_tags
  vpc_cidr               = var.vpc_cidr
  private_subnet_count   = var.private_subnet_count
  public_subnet_count    = var.public_subnet_count
  private_subnets_cidr   = var.private_subnets_cidr
  public_subnets_cidr   = var.public_subnets_cidr
  availability_zones     = var.availability_zones
  source                 = "./modules/networking"
}

module "instances" {
  default_tags           = var.default_tags
  vpc_id                  = module.networking.vpc_id
  instance_type           = var.instance_type
  public_subnet_id       = module.networking.public_subnet_id
  volume_size             = var.volume_size
  volume_type             = var.volume_type
  public_key              = var.public_key
  source                  = "./modules/instances"
}

module "eks" {
  default_tags           = var.default_tags
  vpc_id                  = module.networking.vpc_id
  private_subnet_id       = module.networking.private_subnet_id
  cluster_name = var.cluster_name
  cluster_version = var.cluster_version
  ng_ami_type = var.ng_ami_type
  ng_disk_size = var.ng_disk_size
  ng_instance_types = var.ng_instance_types
  ng_min_size = var.ng_min_size
  ng_max_size = var.ng_max_size
  ng_desired_size = var.ng_desired_size
  cluster_enabled_log_types = var.cluster_enabled_log_types
  source                  = "./modules/eks"
}

module "rds" {
  default_tags           = var.default_tags
  vpc_id                  = module.networking.vpc_id
  private_subnet_id = module.networking.private_subnet_id
  multi_az = var.multi_az
  rds_storage = var.rds_storage
  rds_version = var.rds_version
  rds_instance_class = var.rds_instance_class
  default_db = var.default_db
  default_admin_user = var.default_admin_user
  default_admin_password = var.default_admin_password
  private_subnets_cidr = var.private_subnets_cidr
  availability_zones     = var.availability_zones
  source                  = "./modules/rds"
}

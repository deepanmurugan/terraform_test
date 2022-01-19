resource "aws_db_subnet_group" "prod_db_subnet_group" {
  name       = lower("${lookup(var.default_tags, "AppName", "Provide Proper Key")}subnetgroup")
  subnet_ids = var.private_subnet_id
  tags = merge(
    var.default_tags,
    {
      Name = "${lookup(var.default_tags, "AppName", "Provide Proper Key")}subnetgroup"
    },
  )
}

resource "aws_db_parameter_group" "prod_db_parameter_group" {
  name   = lower("${lookup(var.default_tags, "AppName", "Provide Proper Key")}paramgroup")
  family = "postgres11"
}

resource "aws_security_group" "postgres" {
  name        = "allow_postgres"
  description = "Allow Postgres"
  vpc_id      = var.vpc_id
  ingress {
    description      = "TLS from VPC"
    from_port        = "5432"
    to_port          = "5432"
    protocol         = "tcp"
    cidr_blocks      = var.private_subnets_cidr
  }
  tags = merge(
    var.default_tags,
    {
      Name = "${lookup(var.default_tags, "AppName", "Provide Proper Key")}-SG"
    },
  )
}

resource "aws_db_instance" "prod-rds" {
  identifier = lower("${lookup(var.default_tags, "AppName", "Provide Proper Key")}-RDS")
  allocated_storage    = var.rds_storage
  auto_minor_version_upgrade = false
  apply_immediately = true
  copy_tags_to_snapshot = true
  db_subnet_group_name = aws_db_subnet_group.prod_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.postgres.id]
  multi_az = var.multi_az
  allow_major_version_upgrade = false
  storage_type = "gp2"
  engine               = "postgres"
  engine_version       = var.rds_version
  instance_class       = var.rds_instance_class
  name                 = var.default_db
  username             = var.default_admin_user
  password             = var.default_admin_password
  parameter_group_name = aws_db_parameter_group.prod_db_parameter_group.name
  skip_final_snapshot = true
  backup_retention_period = 5
}

resource "aws_db_instance" "prod-read-replica" {
  count = 2 
  identifier = lower("${lookup(var.default_tags, "AppName", "Provide Proper Key")}-Postgres-${count.index}")
  replicate_source_db = aws_db_instance.prod-rds.id
  allocated_storage    = var.rds_storage
  auto_minor_version_upgrade = false
  apply_immediately = true
  copy_tags_to_snapshot = true
  vpc_security_group_ids = [aws_security_group.postgres.id]
  multi_az = var.multi_az
  allow_major_version_upgrade = false
  storage_type = "gp2"
  engine               = "postgres"
  engine_version       = var.rds_version
  instance_class       = var.rds_instance_class
  parameter_group_name = aws_db_parameter_group.prod_db_parameter_group.name
  skip_final_snapshot = true
}

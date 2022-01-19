resource "aws_elasticache_subnet_group" "elasticache_subnet_group" {
  name       = lower("${lookup(var.default_tags, "AppName", "Provide Proper Key")}ecsubnetgroup")
  subnet_ids = var.private_subnet_id
  tags = merge(
    var.default_tags,
    {
      Name = "${lookup(var.default_tags, "AppName", "Provide Proper Key")}-EC-SubnetGroup"
    },
  )
}

resource "aws_elasticache_parameter_group" "elasticache_parameter_group" {
  name   = lower("${lookup(var.default_tags, "AppName", "Provide Proper Key")}ecparamgroup")
  family = "redis5.0"
}

resource "aws_elasticache_replication_group" "elasticache_replica" {
  availability_zones = var.availability_zones
  replication_group_id          = lower("${lookup(var.default_tags, "AppName", "Provide Proper Key")}-redis")
  replication_group_description = lower("${lookup(var.default_tags, "AppName", "Provide Proper Key")}-redis")
  subnet_group_name = aws_elasticache_subnet_group.elasticache_subnet_group.name
  node_type                     = var.redis_node_type
  engine_version = var.redis_engine_version
  port                          = 6379
  parameter_group_name          = aws_elasticache_parameter_group.elasticache_parameter_group.name
  automatic_failover_enabled    = true
  multi_az_enabled = true

  cluster_mode {
    replicas_per_node_group = 1
    num_node_groups         = 1
  }

  tags = merge(
    var.default_tags,
    {
      Name = "${lookup(var.default_tags, "AppName", "Provide Proper Key")}-Redis"
    },
  )
}

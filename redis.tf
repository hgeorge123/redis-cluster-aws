resource "aws_elasticache_replication_group" "this" {
  description          = "Redis Replication Group"
  replication_group_id = "redis-${var.git}"
  multi_az_enabled     = true
  availability_zones   = ["us-east-1a", "us-east-1a"]
  engine               = "redis"
  engine_version       = var.engine_version
  maintenance_window   = var.maintenance_window
  node_type            = var.node_type
  num_cache_clusters   = var.num_cache_clusters
  port                 = var.redis_port
  # num_node_groups         = 2
  # replicas_per_node_group = 1
  auto_minor_version_upgrade = true
  parameter_group_name       = aws_elasticache_parameter_group.this.name
  subnet_group_name          = aws_elasticache_subnet_group.this.name
  automatic_failover_enabled = var.automatic_failover_enabled
  transit_encryption_enabled = var.transit_encryption_enabled
  snapshot_retention_limit   = var.snapshot_retention_limit
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  security_group_ids         = [aws_security_group.this.id]
  auth_token                 = random_password.password.result
  # tags {
  #   Name                  = "scholarone.s1services.cache"
  #   "tr":"appName"          = "scholarone"
  #   "tr:appFamily"        = "scholarone"
  #   "tr:role"             = "redis"
  #   "tr:environment-type" = "dev"
  #   "s1:environment-type" = "s1services"
  #   "s1:environment-name" = "s1services"
  #   "s1:role"             = "cache"
  #   "created-by"          = "terraform"
  # }

  # log_delivery_configuration {
  #   destination      = aws_cloudwatch_log_group.redis_slow.name
  #   destination_type = "cloudwatch-logs"
  #   log_format       = "json"
  #   log_type         = "slow-log"
  # }
  # log_delivery_configuration {
  #   destination      = aws_cloudwatch_log_group.redis_engine.name
  #   destination_type = "cloudwatch-logs"
  #   log_format       = "json"
  #   log_type         = "engine-log"
  # }
}

resource "aws_elasticache_subnet_group" "this" {
  name        = "${var.git}-sg-${random_string.identifier.result}"
  description = "private subnets for the elastic cache cluster"
  subnet_ids  = var.subnet_ids
}

resource "aws_elasticache_parameter_group" "this" {
  name        = "${var.git}-reddis-cluster-${random_string.identifier.result}"
  family      = var.redis_family
  description = "Redis default cluster parameter group"

  parameter {
    name  = "cluster-enabled"
    value = "yes"
  }
}
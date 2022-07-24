variable "git" {
  description = "Name of the Git repo"
  type        = string
  default     = "terraform-aws-redis"
}

variable "tags" {
  description = "Tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "engine_version" {
  type    = string
  default = "3.2.6"
}

variable "node_type" {
  type    = string
  default = "cache.t2.micro"
}

variable "maintenance_window" {
  type    = string
  default = "sun:07:00-sun:08:00"
}

variable "num_cache_clusters" {
  type    = number
  default = 3
}

variable "redis_port" {
  type    = number
  default = 6379
}

variable "vpc_id" {
  type    = string
  default = "vpc-09c23c912f752ac32"
}

variable "source_security_group_id" {
  default     = ""
  type        = string
}

variable "subnet_ids" {
  default     = ["subnet-0a28415e260239f42", "subnet-0c885bba2c43df0db"]
  type        = list(string)
}

variable "redis_family" {
  default     = "redis3.2"
  type        = string
}

variable "transit_encryption_enabled" {
  type        = bool
  default     = true
}

variable "automatic_failover_enabled" {
  type        = bool
  default     = true
}

variable "snapshot_retention_limit" {
  type        = number
  default     = 5
}

variable "at_rest_encryption_enabled" {
  type        = bool
  default     = true
}

variable "db_instance_class" {
  default = "db.t3.micro"
}

variable "db_name" {
  default = "flowerdb"
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  description = "DB password (use tfvars or Secrets Manager)"
  sensitive   = true
}

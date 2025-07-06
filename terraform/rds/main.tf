# Retrieve secret from AWS Secrets Manager
data "aws_secretsmanager_secret" "db_creds" {
  name = "flower-db-creds"
}

data "aws_secretsmanager_secret_version" "db_creds_version" {
  secret_id = data.aws_secretsmanager_secret.db_creds.id
}

locals {
  db_creds = jsondecode(data.aws_secretsmanager_secret_version.db_creds_version.secret_string)
}

# Create RDS MySQL instance
module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.3.1"

  identifier = "${var.cluster_name}-mysql"

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = var.db_instance_class
  allocated_storage = 20

  name     = var.db_name
  username = local.db_creds.username
  password = local.db_creds.password

  vpc_security_group_ids = [module.eks.cluster_security_group_id]
  subnet_ids             = module.vpc.private_subnets

  multi_az             = false
  publicly_accessible  = false
  skip_final_snapshot  = true
  deletion_protection  = false

  db_subnet_group_name = "${var.cluster_name}-db-subnet-group"
}

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.3.1"

  identifier = "${var.cluster_name}-mysql"

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = var.db_instance_class
  allocated_storage = 20

  name     = var.db_name
  username = var.db_username
  password = var.db_password

  vpc_security_group_ids = [module.eks.cluster_security_group_id]
  subnet_ids             = module.vpc.private_subnets

  publicly_accessible = false
  skip_final_snapshot = true
}

# DATABASE
module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "database-2"

  engine                = "mysql"
  engine_version        = "8.0.33"
  instance_class        = "db.t2.micro"
  allocated_storage     = 5
  max_allocated_storage = 1000

  username = "admin"
  port     = "3306"

  iam_database_authentication_enabled = false
  storage_encrypted                   = false
  copy_tags_to_snapshot               = true
  publicly_accessible                 = true
  skip_final_snapshot                 = true
  allow_major_version_upgrade         = null
  apply_immediately                   = true

  vpc_security_group_ids = [module.web_server_sg.security_group_id]

  maintenance_window = "sat:04:32-sat:05:02"
  backup_window      = "09:34-10:04"

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
  monitoring_interval    = "30"
  monitoring_role_name   = "MyRDSMonitoringRole"
  create_monitoring_role = true

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = module.vpc.public_subnets

  # DB parameter group
  create_db_parameter_group = false
  family                    = "mysql5.7"

  # DB option group
  create_db_option_group = false
  major_engine_version   = "5.7"

  # Database Deletion Protection
  deletion_protection = false
}

# SG TO MYSQL
# module "mysql_security_group" {
#   source  = "terraform-aws-modules/security-group/aws//modules/mysql"
#   version = "~> 5.0"

#   name = "sg_mysql_rds"
#   vpc_id = module.vpc.vpc_id

#   # omitted...
# }
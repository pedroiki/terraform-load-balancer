module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-example-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  database_subnets = [ "10.0.201.0/24", "10.0.202.0/24" ]

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Aulas       = "true"
    Environment = "dev"
    Arquiteto   = "Dallison Lima"
  }
}
module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
}

module "mysql_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/mysql"
  version = "~> 5.0"

  name = "sg_mysql_rds"
  vpc_id = module.vpc.vpc_id

  # omitted...
}
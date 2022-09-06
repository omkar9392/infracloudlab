module "vpc" {
  source = "./modules/vpc"

}
module "ec2" {
  source = "./modules/ec2"
  subnet_id = module.vpc.public_subnets_id[0]
  vpc_security_group_ids = module.vpc.default_sg_id
  depends_on = [ module.vpc, module.vpc.aws_security_group, module.vpc.aws_subnet]
}
module "rds" {
  source = "./modules/rds"
  subnet_ids = module.vpc.private_subnets_id
  vpc_security_group_ids = module.vpc.default_sg_id
  depends_on = [ module.vpc, module.vpc.aws_security_group, module.vpc.aws_subnet]
}

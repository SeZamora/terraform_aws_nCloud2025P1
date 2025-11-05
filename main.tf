module "myvpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  project_name = var.project_name
  owner = var.owner
  ipElastic = var.ipElastic
}

module "myefs" {
  source = "./modules/EFS"
  vpc_cidr = var.vpc_cidr
  project_name = var.project_name
  owner = var.owner
  vpc_id = module.myvpc.vpc_id
  subnet_id = module.myvpc.private_subnet_ids
}

module "myalb" {
  source = "./modules/alb"
  vpc_cidr = var.vpc_cidr
  project_name = var.project_name
  owner = var.owner
  vpc_id = module.myvpc.vpc_id
  subnet_id = module.myvpc.public_subnet_ids
  arn_certificate = var.arn_certificate
}

module "myec2" {
  source = "./modules/ec2"
  vpc_cidr = var.vpc_cidr
  project_name = var.project_name
  owner = var.owner
  vpc_id = module.myvpc.vpc_id
  subnet_id = module.myvpc.private_subnet_ids[0]
  efs_id = module.myefs.efs_id
  efs_sg_id = module.myefs.efs_sg_id
  alb_sg_id = module.myalb.alb_sg_id
  efs_dns_name = module.myefs.efs_dns_name
}

module "myasg" {
  source = "./modules/asg"
  vpc_cidr = var.vpc_cidr
  project_name = var.project_name
  owner = var.owner
  vpc_id = module.myvpc.vpc_id
  subnet_id = module.myvpc.private_subnet_ids
  alb_dns_name = module.myalb.alb_dns_name
  target_group_arn = module.myalb.target_group_arn
  ec2_template_id = module.myec2.ec2_launch_template_id
}

module "myroute53" {
  source = "./modules/r53"
  vpc_cidr = var.vpc_cidr
  project_name = var.project_name
  owner = var.owner
  alb_dns_name = module.myalb.alb_dns_name
  alb_zone_id = module.myalb.alb_zone_id
  domain_name = var.domain_name
  subdomain_name = var.subdomain_name
}


module "vpc" {
  source = "./modules/vpc"
}

module "ecr" {
  source = "./modules/ecr"
}

module "alb" {
  source             = "./modules/alb"
  vpc_id             = module.vpc.vpc_id
  alb_sg_id          = module.vpc.alb_sg_id
  public_subnet_1_id = module.vpc.public_subnet_1_id
  public_subnet_2_id = module.vpc.public_subnet_2_id
  certificate_arn    = module.acm.certificate_arn
}

module "acm" {
  source = "./modules/acm"
}

module "ecs" {
  source             = "./modules/ecs"
  repository_url     = module.ecr.repository_url
  public_subnet_1_id = module.vpc.public_subnet_1_id
  public_subnet_2_id = module.vpc.public_subnet_2_id
  ecs_sg_id          = module.vpc.ecs_sg_id
  target_group_arn   = module.alb.target_group_arn
}

resource "aws_route53_record" "acm_validation" {
  zone_id = var.route53_zone_id
  name    = "_932f79440be4bb044f53ae00f2ece99c.tm.sudaysi.xyz."
  type    = "CNAME"
  ttl     = 60
  records = ["_c88cda5e51cf92e7014f335edb90a688.jkddzztszm.acm-validations.aws."]
}

resource "aws_route53_record" "app" {
  zone_id = var.route53_zone_id
  name    = "tm.sudaysi.xyz"
  type    = "A"

  alias {
    name                   = module.alb.alb_dns_name
    zone_id                = "ZHURV8PSTC4K8"
    evaluate_target_health = true
  }
}

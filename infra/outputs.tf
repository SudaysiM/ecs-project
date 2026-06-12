output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "acm_domain_validation_options" {
  value = module.acm.domain_validation_options
}

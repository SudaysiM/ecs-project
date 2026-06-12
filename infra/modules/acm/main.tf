resource "aws_acm_certificate" "main" {
  domain_name       = "tm.sudaysi.xyz"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

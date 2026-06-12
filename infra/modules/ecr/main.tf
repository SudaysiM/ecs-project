resource "aws_ecr_repository" "main" {
  name         = "myapp"
  force_delete = true
}

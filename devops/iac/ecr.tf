resource "aws_ecr_repository" "main" {
  name                 = "typeorm-express-typescript"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

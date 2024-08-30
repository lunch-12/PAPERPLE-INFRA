resource "aws_ecr_repository" "paperple-spring" {
  name                 = "paperple-spring"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "paperple-ai" {
  name                 = "paperple-ai"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
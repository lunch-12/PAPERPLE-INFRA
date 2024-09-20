resource "aws_db_instance" "paperple" {
  db_name                = "paperple"
  identifier             = "paperple-db"
  engine                 = "mysql"
  engine_version         = var.settings.engine_version
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_subnet_group_name   = var.subnet_group_name
  vpc_security_group_ids = [var.security_group]
  username               = var.db_username
  password               = var.db_password
  multi_az               = false
  skip_final_snapshot    = true
  publicly_accessible    = false
  enabled_cloudwatch_logs_exports = [
    "audit",
    "error",
    "general",
    "slowquery"
  ]

  # lifecycle {
  #  prevent_destroy = true
  # }

  tags = {
    Name = "paperple DB instance"
  }
}

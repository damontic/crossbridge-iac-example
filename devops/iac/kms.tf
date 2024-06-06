resource "aws_kms_key" "main" {
  description             = "main"
  deletion_window_in_days = 7
}

resource "aws_kms_key" "rds" {
  description = "RDS KMS Key"
}

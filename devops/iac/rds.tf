resource "aws_db_instance" "default" {
  allocated_storage             = 10
  db_name                       = "pgres"
  engine                        = "postgres"
  instance_class                = "db.t3.micro"
  manage_master_user_password   = true
  master_user_secret_kms_key_id = aws_kms_key.rds.key_id
  username                      = "foo"
  skip_final_snapshot           = true
}

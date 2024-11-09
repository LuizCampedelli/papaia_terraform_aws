# Secrets Manager secret for RDS password
resource "aws_secretsmanager_secret" "rds_master_password" {
  name = "rds_master_password"
}

# Secret value (initial password)
resource "aws_secretsmanager_secret_version" "rds_master_password_version" {
  secret_id     = aws_secretsmanager_secret.rds_master_password.id
  secret_string = "{\"username\":\"root\",\"password\":\"mustbeeightcharaters\"}"
}

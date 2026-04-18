# modules/secrets/main.tf

resource "aws_secretsmanager_secret" "db_credentials" {
  name       = "production/db/credentials"
  kms_key_id = var.kms_key_arn
  tags       = { Name = "db-credentials" }
}

resource "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = "dbadmin"
    password = var.db_password
    host     = var.rds_endpoint
    port     = 5432
    dbname   = "productiondb"
  })
}
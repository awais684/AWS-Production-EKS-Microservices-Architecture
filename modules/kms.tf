# modules/kms/main.tf

resource "aws_kms_key" "main" {
  description             = "Customer managed key for RDS, Secrets, EKS"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  multi_region            = false

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = { AWS = "arn:aws:iam::${var.account_id}:root" }
        Action   = "kms:*"
        Resource = "*"
      }
    ]
  })

  tags = { Name = "production-cmk" }
}

resource "aws_kms_alias" "main" {
  name          = "alias/production-cmk"
  target_key_id = aws_kms_key.main.key_id
}

output "key_arn" { value = aws_kms_key.main.arn }
output "key_id"  { value = aws_kms_key.main.key_id }
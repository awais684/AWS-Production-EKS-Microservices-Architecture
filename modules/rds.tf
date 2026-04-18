# modules/rds/main.tf

resource "aws_db_subnet_group" "main" {
  name       = "production-db-subnet-group"
  subnet_ids = [var.private_subnet_az1_id, var.private_subnet_az2_id]
  tags       = { Name = "production-db-subnet-group" }
}

resource "aws_security_group" "rds" {
  name        = "rds-sg"
  description = "Allow PostgreSQL from EKS"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.eks_node_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "master" {
  identifier              = "production-postgres-master"
  engine                  = "postgres"
  engine_version          = "15.4"
  instance_class          = "db.t3.medium"
  allocated_storage       = 20
  max_allocated_storage   = 100
  storage_type            = "gp3"
  storage_encrypted       = true
  kms_key_id              = var.kms_key_arn
  db_name                 = "productiondb"
  username                = "dbadmin"
  password                = var.db_password   # pulled from Secrets Manager
  multi_az                = true
  db_subnet_group_name    = aws_db_subnet_group.main.name
  vpc_security_group_ids  = [aws_security_group.rds.id]
  backup_retention_period = 7
  deletion_protection     = true
  skip_final_snapshot     = false
  final_snapshot_identifier = "production-final-snapshot"
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  tags = { Name = "production-postgres" }
}
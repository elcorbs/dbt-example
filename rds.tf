resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.one.id, aws_subnet.two.id]

  tags = {
    Name = "${local.app_name}-default"
  }
}

resource "aws_security_group" "rds" {
  name        = "query_rds"
  description = "Allow inbound TCP traffic to mysql"
  vpc_id      = aws_vpc.main.id
}

resource "aws_security_group_rule" "access_pg_from_mt" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["79.173.131.202/32"]
  security_group_id = aws_security_group.rds.id
}

resource "aws_security_group_rule" "access_pg_from_home" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["82.7.126.59/32"]
  security_group_id = aws_security_group.rds.id
}

resource "aws_db_instance" "source" {
  allocated_storage       = 10
  db_name                 = "case_test_data"
  engine                  = "postgres"
  engine_version          = "14.1"
  instance_class          = "db.t3.micro"
  username                = "emma"
  password                = "mypasswordypassword"
  parameter_group_name    = "default.postgres14"
  skip_final_snapshot     = true
  identifier              = local.app_name
  vpc_security_group_ids  = [aws_security_group.rds.id]
  db_subnet_group_name    = aws_db_subnet_group.default.name
  multi_az                = false
  publicly_accessible     = true
  backup_retention_period = 7
}



resource "aws_db_instance" "target" {
  allocated_storage       = 10
  db_name                 = "decs_plotly_target"
  engine                  = "postgres"
  engine_version          = "14.1"
  instance_class          = "db.t3.micro"
  username                = "emma"
  password                = "mypasswordypassword"
  parameter_group_name    = "default.postgres14"
  skip_final_snapshot     = true
  identifier              = "${local.app_name}-plotly-target"
  vpc_security_group_ids  = [aws_security_group.rds.id]
  db_subnet_group_name    = aws_db_subnet_group.default.name
  multi_az                = false
  publicly_accessible     = true
  backup_retention_period = 7
}


resource "aws_iam_role" "rds" {
  name = local.app_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "rds-export.aws.internal"
        }
      }
    ]
  })
  inline_policy {
    name   = "policy-8675309"
    policy = data.aws_iam_policy_document.inline_policy.json
  }
}


data "aws_iam_policy_document" "inline_policy" {
  statement {
    actions   = ["s3:*"]
    resources = ["*"]
  }
}


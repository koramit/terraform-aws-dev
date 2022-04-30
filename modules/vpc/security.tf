###
# Public Security Group - web proxy
##

resource "aws_security_group" "public" {
  name        = "nephrosi-${var.infra_env}-public-sg"
  description = "Public internet access"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name        = "nephrosi-${var.infra_env}-public-sg"
    Role        = "public"
    Project     = "nephrosi.org"
    Environment = var.infra_env
    ManagedBy   = "terraform"
  }
}

resource "aws_security_group_rule" "public_out" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "public_in_ssh" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "public_in_http" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "public_in_https" {
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.public.id
}


###
# Private Security Group - app server
##

resource "aws_security_group" "private" {
  name        = "nephrosi-${var.infra_env}-private-sg"
  description = "Private internet access"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name        = "nephrosi-${var.infra_env}-private-sg"
    Role        = "private"
    Project     = "nephrosi.org"
    Environment = var.infra_env
    ManagedBy   = "terraform"
  }
}

resource "aws_security_group_rule" "private_out" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.private.id
}

resource "aws_security_group_rule" "private_in" {
  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "-1"
  cidr_blocks = [module.vpc.vpc_cidr_block]

  security_group_id = aws_security_group.private.id
}

###
# Persistance Security Group - database
##

resource "aws_security_group" "persistance" {
  name        = "nephrosi-${var.infra_env}-persistance-sg"
  description = "Persistance tier security group"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name        = "nephrosi-${var.infra_env}-persistance-sg"
    Role        = "persistance"
    Project     = "nephrosi.org"
    Environment = var.infra_env
    ManagedBy   = "terraform"
  }
}

resource "aws_security_group_rule" "persistance_out" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.persistance.id
}

resource "aws_security_group_rule" "postgresql_in" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.private.id

  security_group_id = aws_security_group.persistance.id
}

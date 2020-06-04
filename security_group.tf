resource "aws_security_group" "http" {
  name   = format("%s-http", local.product_name)
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = format("%s-http", local.product_name)
  }
}

resource "aws_security_group_rule" "http-ingress" {
  security_group_id = aws_security_group.http.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "http-egress" {
  security_group_id = aws_security_group.http.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "container" {
  name   = format("%s-container", local.product_name)
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = format("%s-container", local.product_name)
  }
}

resource "aws_security_group_rule" "container-ingress" {
  security_group_id = aws_security_group.container.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "container-egress" {
  security_group_id = aws_security_group.container.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}


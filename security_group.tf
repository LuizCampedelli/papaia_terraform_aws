resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow http inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.terra_vpc.id

  tags = {
    Name = "allow_http"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.allow_http.id
  cidr_ipv4         = aws_vpc.terra_vpc.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_http.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semanticamente, -1 significa todos os protocolos.
}

# Security group for RDS
resource "aws_security_group" "rds_sg" {
  name   = "rds_sg"
  vpc_id = aws_vpc.terra_vpc.id

  tags = {
    Name = "rds_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "rds_sg" {
  security_group_id = aws_security_group.rds_sg.id
  cidr_ipv4         = aws_vpc.terra_vpc.cidr_block
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}

resource "aws_vpc_security_group_egress_rule" "rds_sg" {
  security_group_id = aws_security_group.rds_sg.id
  from_port         = 0
  to_port           = 0
  ip_protocol       = "-1"
  cidr_ipv4         = "10.0.0.0/16"
}

resource "aws_security_group" "lb_sg" {
  name        = "papaia-lb_sg"
  vpc_id      = aws_vpc.terra_vpc.id

  tags = {
    Name = "papaia-lb_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "lb_sg" {
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv4         = aws_vpc.terra_vpc.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "lb_sg" {
  security_group_id = aws_security_group.lb_sg.id
  from_port         = 0
  to_port           = 0
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

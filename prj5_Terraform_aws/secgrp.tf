resource "aws_security_group" "prj1-instance-sg" {
  name        = "prj1-instance-sg"
  description = "prj1-instance-sg"
  // vpc_id      = aws_vpc.main.id

  tags = {
    Name = "prj1-instance-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "sshfrommyIP" {
  security_group_id = aws_security_group.prj1-instance-sg.id
  cidr_ipv4         = "119.82.95.242/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}


resource "aws_vpc_security_group_ingress_rule" "sshfromanywhere" {
  security_group_id = aws_security_group.prj1-instance-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.prj1-instance-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.prj1-instance-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.prj1-instance-sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

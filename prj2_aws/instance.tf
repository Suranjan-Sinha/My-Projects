resource "aws_instance" "web" {
  ami                    = var.amiID[var.region]
  instance_type          = "t2.micro"
  key_name               = "devops-key"
  vpc_security_group_ids = [aws_security_group.prj1-instance-sg.id]
  availability_zone      = var.zone1

  tags = {
    Name    = "prj2"
    Project = "devops"
  }
}

resource "aws_ec2_instance_state" "web-state" {
  instance_id = aws_instance.web.id
  state       = "running"
}
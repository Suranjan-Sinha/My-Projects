provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "web01" {
  # ami           = "ami-0d729a60"
  # ami           = "ami-0e2c8caa4b6378d8c"
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type.web01

  subnet_id = module.vpc.public_subnets[0]

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  key_name = aws_key_pair.id_ed25519.key_name

  //user_data = templatefile("C:/Users/dsinh/terraform-course/first-steps/templates/web.tpl", {
  //  "region" = var.aws_region
  //})

  tags = {
    Name = "web01"
  }
}


resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_key_pair" "id_ed25519" {
  key_name   = "id_ed25519-demo"
  // public_key = file("${path.module}/id_ed25519.pub")
  // public_key = file("C:/Users/dsinh/.ssh/id_ed25519.pub")
  public_key = file("../../.ssh/id_ed25519.pub")
}


resource "aws_instance" "web" {
  ami                    = var.amiID[var.region]
  instance_type          = "t2.micro"
  key_name               = "devops-key"
  vpc_security_group_ids = [aws_security_group.prj1-instance-sg.id]
  availability_zone      = var.zone1

  tags = {
    Name    = "prj3"
    Project = "devops"
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  connection {
    type        = "ssh"
    user        = var.webuser
    private_key = file("C:/Users/dsinh/My-Projects-key/devops-key")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]

  }

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }

}

resource "aws_ec2_instance_state" "web-state" {
  instance_id = aws_instance.web.id
  state       = "running"
}

output "public_ip" {
  description = "AMI ID of Ubuntu instance"
  value       = aws_instance.web.public_ip
}

output "private_ip" {
  description = "AMI ID of Ubuntu instance"
  value       = aws_instance.web.private_ip
}
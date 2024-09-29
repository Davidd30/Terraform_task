resource "aws_security_group" "David_SG" {
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id = var.vpc_id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.allow_all_ipv4_cidr_blocks]
    ipv6_cidr_blocks = [var.allow_all_ipv6_cidr_blocks]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [var.allow_all_ipv4_cidr_blocks]
    ipv6_cidr_blocks = [var.allow_all_ipv6_cidr_blocks]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.allow_all_ipv4_cidr_blocks]
    ipv6_cidr_blocks = [var.allow_all_ipv6_cidr_blocks]
  }

  tags = {
    Name = "to_allow_ssh,http"
  }
}

resource "aws_instance" "David-EC2" {
  ami = coalesce(var.ec2-ami, data.aws_ami.ubuntu.id)
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  associate_public_ip_address = var.is_public
  vpc_security_group_ids = [aws_security_group.David_SG.id]
  key_name = var.key-name

  provisioner "local-exec" {
    command = var.is_public ? "echo public-ip-${var.item-count} ${self.public_ip} >> IPs.txt" : "echo private-ip$-${var.item-count} ${self.private_ip} >> IPs.txt"
  }

  provisioner "remote-exec" {

      inline = var.my-remote-commands

      connection {
        type = "ssh"
        host = var.is_public ? self.public_ip : self.private_ip
        user = "ubuntu"
        private_key = file(var.path-to-pem-file)

        bastion_host = var.is_public ? "" : var.bastion_host_ip
        bastion_user = var.is_public ? "" :  "ubuntu"
        bastion_host_key = var.is_public ? "" : file(var.path-to-pem-file)
      }
  }
}
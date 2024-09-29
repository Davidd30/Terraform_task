output "instance_ids" {
  value = aws_instance.David_EC2.id
}

output "public_ip" {
  value = aws_instance.David_EC2.public_ip
}

output "private_ip" {
  value = aws_instance.David_EC2.private_ip
}



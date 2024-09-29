variable "vpc_id" {

}

variable "allow_all_ipv4_cidr_blocks" {
  type = string
  default = "0.0.0.0/0"
}

variable "allow_all_ipv6_cidr_blocks" {
  type = string
  default = "::/0"
}

variable "ec2-ami" {
  default = ""
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "subnet_id" {
  
}

variable "is_public" {

}

variable "key-name" {
  
}

variable "my-remote-commands" {
  default = []
}

variable "item-count" {
  
}

variable "path-to-pem-file" {
  
}

variable "bastion_host_ip" {
  default = ""
}
variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "subnet_cidr_blocks" {
  description = "subnet cidr block map ex. {cidr1=10.0.0.0/24,10.0.2.0/24}"
  type = map
}

variable "allow_all_ipv4_cidr_blocks" {
  type = string
  default = "0.0.0.0/0"
}

variable "allow_all_ipv6_cidr_blocks" {
  type = string
  default = "::/0"
}

variable "public-subnet-key-to-nat" {
  
}

variable "keys-of-public-subnets" {
  type = list
}

variable "keys-of-private-subnets" {
  type = list
}

variable "subnet_types" {
  type = map
}

variable "lb_name" {
  
}

variable "is_lb_internal" {
  
}

variable "lb_subnets_ids" {
  
}

variable "ec2_instance_ids" {

}

variable "target_group_name" {
  
}

variable "target_group_type" {
  
}

variable "vpc_id" {

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
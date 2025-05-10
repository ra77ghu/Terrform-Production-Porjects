resource "aws_security_group" "bastion_sg" {
  name = "${var.project_name}-bastion-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "Allow ssh from trusted IPs"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = var.allowed_ssh_cidrs
  }
  egress {
    description = "Allow all outbound traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "bastion" {
  ami = var.ami_value
  key_name = var.key_name
  instance_type = var.instance_type
  subnet_id = var.bastian_public_subnet
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "${var.project_name}-bastion"
  }
}



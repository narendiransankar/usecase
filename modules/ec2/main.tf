resource "aws_instance" "instance_a" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_ids[0]
  associate_public_ip_address = true 
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  user_data = file("${path.module}/userdata0.sh")

  tags = {
    Name = "Instance-A-Homepage"
  }
}

resource "aws_instance" "instance_b" {
#   count                  = length(var.subnet_ids)
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_ids[1]
  associate_public_ip_address = true 
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  user_data = file("${path.module}/userdata1.sh")
  tags = {
    Name = "Instance-B-Images"
  }
}

resource "aws_instance" "instance_c" {
#   count                  = length(var.subnet_ids)
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_ids[2]
  associate_public_ip_address = true 
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  user_data = file("${path.module}/userdata2.sh")
  tags = {
    Name = "Instance-C-Register"
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Allow HTTP traffic from laod balancer"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = "dev"
  }
}

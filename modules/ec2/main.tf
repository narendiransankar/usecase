resource "aws_instance" "instance_a" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_ids[0]
  associate_public_ip_address = true 
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  user_data = file("${path.module}/userdata0.sh")
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "Welcome to Home Page" > /var/www/html/index.html
              EOF
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
  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y apache2
              systemctl start apache2
              systemctl enable apache2
              mkdir -p /var/www/html/images
              echo "<h1>Welcome to Images</h1>" > /var/www/html/images/index.html
              EOF

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
  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y apache2
              systemctl start apache2
              systemctl enable apache2
              mkdir -p /var/www/html/register
              echo "<h1>Welcome to Register</h1>" > /var/www/html/register/index.html
              EOF

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
    security_groups = [var.alb_security_group_id]
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

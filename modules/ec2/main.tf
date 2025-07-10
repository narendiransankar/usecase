resource "aws_instance" "instance_a" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_ids[0]
  associate_public_ip_address = true 
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install nginx -y
              systemctl start nginx
              systemctl enable nginx
              echo "<h1>Welcome to Homepage</h1>" > /usr/share/nginx/html/index.html
              EOF
#   user_data = <<-EOF
#                 #!/bin/bash
#                 set -e  # Exit on error

#                 # Update system packages
#                 yum update -y

#                 # Set the system crypto policy to FUTURE
#                 update-crypto-policies --set FUTURE

#                 # Lock down SELinux by updating the configuration file
#                 sed -i 's/^SELINUX=.*/SELINUX=enforcing/' /etc/selinux/config

#                 # Temporarily set SELinux to enforcing mode
#                 setenforce 1

#                 # Install NGINX
#                 yum install nginx -y

#                 # Start and enable NGINX
#                 systemctl start nginx
#                 systemctl enable nginx

#                 # Create HTML directory and file
#                 mkdir -p /usr/share/nginx/html/images
#                 echo "<h1>Welcome to homepage</h1>" > /usr/share/nginx/html/index.html
#                 EOF

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

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install nginx -y
              systemctl start nginx
              systemctl enable nginx
              mkdir -p /usr/share/nginx/html/images
              echo "<h1>Welcome to Images</h1>" > /usr/share/nginx/html/images/index.html
              EOF
#   user_data = <<-EOF
#                 #!/bin/bash
#                 set -e  # Exit on error

#                 # Update system packages
#                 yum update -y

#                 # Set the system crypto policy to FUTURE
#                 update-crypto-policies --set FUTURE

#                 # Lock down SELinux by updating the configuration file
#                 sed -i 's/^SELINUX=.*/SELINUX=enforcing/' /etc/selinux/config

#                 # Temporarily set SELinux to enforcing mode
#                 setenforce 1

#                 # Install NGINX
#                 yum install nginx -y

#                 # Start and enable NGINX
#                 systemctl start nginx
#                 systemctl enable nginx

#                 # Create HTML directory and file
#                 mkdir -p /usr/share/nginx/html/images
#                 echo "<h1>Welcome to Images</h1>" > /usr/share/nginx/html/images/index.html
#                 EOF  
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

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install nginx -y
              systemctl start nginx
              systemctl enable nginx
              mkdir -p /usr/share/nginx/html/register
              echo "<h1>Welcome to Register</h1>" > /usr/share/nginx/html/register/index.html
              EOF

#   user_data = <<-EOF
#             #!/bin/bash
#             set -e  # Exit on error

#             # Update system packages
#             yum update -y

#             # Set the system crypto policy to FUTURE
#             update-crypto-policies --set FUTURE

#             # Lock down SELinux by updating the configuration file
#             sed -i 's/^SELINUX=.*/SELINUX=enforcing/' /etc/selinux/config

#             # Temporarily set SELinux to enforcing mode
#             setenforce 1

#             # Install NGINX
#             yum install nginx -y

#             # Start and enable NGINX
#             systemctl start nginx
#             systemctl enable nginx

#             # Create HTML directory and file
#             mkdir -p /usr/share/nginx/html/images
#             echo "<h1>Welcome to register</h1>" > /usr/share/nginx/html/register/index.html
#             EOF
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
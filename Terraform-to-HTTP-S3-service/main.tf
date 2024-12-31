provider "aws" {
  region = var.aws_region
}

resource "aws_key_pair" "mykey" {
  key_name   = "terra-key"
  public_key = file("/home/ubuntu/.ssh/terra-key.pub")
}

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "http_service_sg" {
  name        = "allow TLS"
  description = "Allow user to connect"
  vpc_id      = aws_default_vpc.default.id
  ingress {
    description = "port 22 allow"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = " allow all outgoing traffic "
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "port 5000 allow"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "port 443 allow"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mysecurity"
  }
}

resource "aws_instance" "http_service" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = aws_key_pair.mykey.key_name
  security_groups = [aws_security_group.http_service_sg.name]
  # User data to install necessary packages and start the HTTP service
  user_data = file("user-data.sh")
  tags = {
    Name = "HTTP-S3-Service"
  }
}
# Output instance public IP
output "instance_public_ip" {
  value = aws_instance.http_service.public_ip
}

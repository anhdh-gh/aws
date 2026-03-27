terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.17.0"
    }
  }
}
# ---------------------------- Security Group ----------------------------
resource "aws_security_group" this {
  vpc_id = var.vpc_id

  # -------- Inbound --------
  # Khoảng port allow (SSH)
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ # Cho phép traffic đến từ CIDR này
      "0.0.0.0/0"
    ]
  }
  # Khoảng port allow (Allow for API)
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = [ # Cho phép traffic đến từ CIDR này
      "0.0.0.0/0"
    ]
  }

  # -------- Outbound --------
  egress {
    from_port = 0 # all
    to_port = 0 # all
    protocol = "-1" # all
    cidr_blocks = [ # Cho phép traffic đến từ CIDR này
      "0.0.0.0/0"
    ]
  }
}

# ---------------------------- EC2 ----------------------------
resource "aws_instance" this {
  ami = var.aws_instance_ami
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  vpc_security_group_ids = [
    aws_security_group.this.id
  ]
  key_name = var.key_name
  tags = {
    Name = var.instance_name
  }
}
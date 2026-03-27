provider "aws" {
  region = "ap-southeast-1"
}

# ------------ Network ------------
data "aws_availability_zones" this {}
module "networking" {
  source = "./modules/networking"
  az = data.aws_availability_zones.this.names[0]
}

# ------------ EC2 ------------
data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"]
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

module "ec2" {
  source = "./modules/ec2"

  aws_instance_ami = data.aws_ami.ubuntu.id
  vpc_id           = module.networking.vpc_id
  subnet_id        = module.networking.presentation_public_subnet_id
  key_name         = "app-ec2-key" # Key SSH
  instance_name    = "app-ec2"
  instance_type    = "t2.micro"
}

output "public_ip_ec2" {
  value = module.ec2.public_ip_ec2
}
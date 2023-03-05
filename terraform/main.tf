# Basic AWS configuration which will grab our keys from the AWS CLI
# If you are not using the keys in the default profile of aws cli, then change below to the profile name 
provider "aws" {
  profile = "terraform"
  region     = var.REGION
}

# Our AWS keypair
resource "aws_key_pair" "terraformkey" {
  key_name   = "${terraform.workspace}-cloudlab"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

# Our VPC definition, using a default IP range of 10.0.0.0/16
resource "aws_vpc" "lab-vpc" {
  cidr_block           = var.VPC_CIDR
  enable_dns_support   = true
  enable_dns_hostnames = true
}

####### NETWORK #######

# Default route required for the VPC to push traffic via gateway
resource "aws_route" "lab-internet-route" {
  route_table_id         = aws_vpc.lab-vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.lab-vpc-gateway.id
}

# Gateway which allows outbound and inbound internet access to the VPC
resource "aws_internet_gateway" "lab-vpc-gateway" {
  vpc_id = aws_vpc.lab-vpc.id
}

# Create our first subnet (Defaults to 10.1.0.0/24)
resource "aws_subnet" "lab-vpc-subnet-1" {
  vpc_id = aws_vpc.lab-vpc.id

  cidr_block        = var.SUBNET1_CIDR
  availability_zone = "eu-central-1a"

  tags = {
    Name = "Lab Subnet 1"
  }
}

# Set DHCP options for delivering things like DNS servers
resource "aws_vpc_dhcp_options" "lab-dhcp" {
  domain_name          = "middle-earth.local"
  domain_name_servers  = [var.DC01_IP, var.PUBLIC_DNS]
  ntp_servers          = [var.DC01_IP]
  netbios_name_servers = [var.DC01_IP]
  netbios_node_type    = 2

  tags = {
    Name = "DHCP middle-earth"
  }
}

# Associate our DHCP configuration with our VPC
resource "aws_vpc_dhcp_options_association" "lab-dhcp-assoc" {
  vpc_id          = aws_vpc.lab-vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.lab-dhcp.id
}


output "timestamp" {
  value = formatdate("hh:mm", timestamp())
}
output "dc01" {
  value       = "${aws_instance.dc01.public_ip}"
  description = "Public IP of DC01"
}
output "srv01" {
  value       = "${aws_instance.srv01.public_ip}"
  description = "Public IP of SRV01"
}
output "dc02" {
  value       = "${aws_instance.dc02.public_ip}"
  description = "Public IP of DC02"
}
output "srv02" {
  value       = "${aws_instance.srv02.public_ip}"
  description = "Public IP of SRV02"
}
output "dc03" {
  value       = "${aws_instance.dc03.public_ip}"
  description = "Public IP of DC03"
}
output "srv03" {
  value       = "${aws_instance.srv03.public_ip}"
  description = "Public IP of SRV03"
}


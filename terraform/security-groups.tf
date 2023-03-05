####### TODO  #######
####### SECURITY GROUPS #######

## Security group subnet 1
resource "aws_security_group" "lab-sg-1" {
  vpc_id = aws_vpc.lab-vpc.id

  ingress {
    protocol    = "-1"
    cidr_blocks = [var.SUBNET1_CIDR]
    from_port   = 0
    to_port     = 0
  }

  # Allow management from our IP
  ingress {
    protocol    = "-1"
    cidr_blocks = var.MANAGEMENT_IPS
    from_port   = 0
    to_port     = 0
  }

  # Allow global outbound
  egress {
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
  }
}

## Security group subnet 2
resource "aws_security_group" "lab-sg-2" {
  vpc_id = aws_vpc.lab-vpc.id

  ingress {
    protocol    = "-1"
    cidr_blocks = [var.SUBNET1_CIDR]
    from_port   = 0
    to_port     = 0
  }

  # Allow management from our IP
  ingress {
    protocol    = "-1"
    cidr_blocks = var.MANAGEMENT_IPS
    from_port   = 0
    to_port     = 0
  }

  # Allow global outbound
  egress {
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
  }
}

## Security group subnet 3
resource "aws_security_group" "lab-sg-3" {
  vpc_id = aws_vpc.lab-vpc.id

  ingress {
    protocol    = "-1"
    cidr_blocks = [var.SUBNET1_CIDR]
    from_port   = 0
    to_port     = 0
  }

  # Allow management from our IP
  ingress {
    protocol    = "-1"
    cidr_blocks = var.MANAGEMENT_IPS
    from_port   = 0
    to_port     = 0
  }

  # Allow global outbound
  egress {
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
  }
}

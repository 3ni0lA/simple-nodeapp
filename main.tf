# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
 resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
#Subnet config block
resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
}

#Internet gateway block
resource "aws_internet_gateway" "gate" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "my VPC gateway"
  }
}

#Route table block
resource "aws_route_table" "route" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gate.id
  }

  
    tags = {
    Name = "vpc route table"
  }
}

resource "aws_route_table_association" "vpc_routetable" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route.id
}

#Security group / Firewall configuration block
resource "aws_security_group" "sg" {
  name        = "sg"
  description = "Allow SSH, HTTP, and custom application traffic"
  vpc_id = aws_vpc.main.id
 
   ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"                 #Allows HTTP from anywhere
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"                 
    cidr_blocks = ["0.0.0.0/0"]
  }
    # Adding ingress rule for Node.js application on port 3000
    ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Custom application (Node.js)"
 }
 
    tags = {
      Name = "sg"
    }
}


#Instance configuration block
resource "aws_instance" "nodeapp" {
  ami           = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"
  key_name = "terrafrom"
  vpc_security_group_ids = [ aws_security_group.sg.id ]
  subnet_id = aws_subnet.subnet1.id
  associate_public_ip_address = true

  tags = {
    Name = "nodeapp"
  }
}


resource "aws_lb" "node_app" {
  name               = "node-app-alb"
  internal           = false
  load_balancer_type = "network"
  security_groups    = [aws_security_group.sg.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  enable_deletion_protection = false

  tags = {
    Name = "NodeAppALB"
  }
}

resource "aws_lb_target_group" "node_app" {
  name     = "node-app-tg"
  port     = 3000
  protocol = "TCP"
  vpc_id   = aws_vpc.main.id 

}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.node_app.arn
  port              = "3000"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.node_app.arn
  }
}

resource "aws_lb_target_group_attachment" "node_app_attachment" {
  target_group_arn = aws_lb_target_group.node_app.arn
  target_id        = aws_instance.nodeapp.id
  port             = 3000
}


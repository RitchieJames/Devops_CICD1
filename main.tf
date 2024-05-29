#######################################################################
##Build server  with functionalities  Jenkins/Maven

resource "aws_instance" "Build_server" {
  ami           = "ami-0bb84b8ffd87024d8"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.Build_SG.id]

  tags = {
    Name = "Build_server"
  }
}

resource "aws_security_group" "Build_SG" {
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["172.31.0.0/16"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
    tags = {
    Name = "Build_SG"
  }

}

#Private ip interface
resource "aws_network_interface" "private_Build_server" {
    subnet_id = "subnet-0513abf3db97a734c"
    private_ips = ["172.31.22.10"]
    }
    
resource "aws_network_interface_attachment" "private_Build_attachment" {
    instance_id = aws_instance.Build_server.id
    device_index = 1
    network_interface_id = aws_network_interface.private_Build_server.id
  }



#########################################################################
####Deployment server with functionality of Docker

resource "aws_instance" "Deployment_server" {
  ami           = "ami-0bb84b8ffd87024d8"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.Deployment_SG.id]
    tags = {
    Name = "Deployment_server"
  }
}
#Private ip interface
resource "aws_network_interface" "private_Deployment_server" {
    subnet_id = "subnet-0513abf3db97a734c"
    private_ips = ["172.31.22.11"]
    }
    
resource "aws_network_interface_attachment" "private_Deployment_attachment" {
    instance_id = aws_instance.Deployment_server.id
    device_index = 1
    network_interface_id = aws_network_interface.private_Deployment_server.id
  }

resource "aws_security_group" "Deployment_SG" {
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["172.31.0.0/16"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  tags = {
    Name = "Deployment_SG"
  }
}



#####################################################################
##AWS Instance Resource for Ansible  server
resource "aws_instance" "Ansible_server" {
  ami           = "ami-0bb84b8ffd87024d8"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.Ansible_SG.id]
  user_data = file("startup.sh")
  tags = {
    Name = "Ansible_server"
  }
}

#Private ip interface
resource "aws_network_interface" "private_Ansible_server" {
    subnet_id = "subnet-0513abf3db97a734c"
    private_ips = ["172.31.22.12"]
    }
    
resource "aws_network_interface_attachment" "private_Ansible_attachment" {
    instance_id = aws_instance.Ansible_server.id
    device_index = 1
    network_interface_id = aws_network_interface.private_Ansible_server.id
  }

resource "aws_security_group" "Ansible_SG" {

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["172.31.0.0/16"]
  }
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  tags = {
    Name = "Ansible_SG"
  }
}

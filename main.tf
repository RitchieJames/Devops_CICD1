
#provider "aws" {
 # region = "us-east-1"
#}

##Jenkins server 
resource "aws_instance" "Jenkins_server" {
  ami           = "ami-0bb84b8ffd87024d8"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.Jenkins_SG.id]

  tags = {
    Name = "Jenkins_server"
  }
}

resource "aws_security_group" "Jenkins_SG" {
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
  tags = {
    Name = "Jenkins_SG"
  }
}
####Docker Host

resource "aws_instance" "Docker_host" {
  ami           = "ami-0bb84b8ffd87024d8"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.Jenkins_SG.id]
    tags = {
    Name = "Docker_host"
  }
}
#Private ip interface

resource "aws_network_interface_attachment" "private_attachment" {
    instance_id = aws_instance.Docker_host.id
    device_index = 1
    network_interface_id = aws_network_interface.private.id
  }

resource "aws_network_interface" "private" {
    subnet_id = "subnet-0513abf3db97a734c"
    private_ips = ["172.31.22.10"]
    }
  




resource "aws_security_group" "Docker_SG" {
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
  tags = {
    Name = "Docker_SG"
  }
}

##Ansible server

resource "aws_instance" "Ansible_server" {
  ami           = "ami-0bb84b8ffd87024d8"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.Jenkins_SG.id]

  tags = {
    Name = "Ansible_server"
  }
}

resource "aws_security_group" "Ansible_SG" {
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "Ansible_SG"
  }
}
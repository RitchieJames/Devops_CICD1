##Build server  with functionalities  Jenkins/Maven
#AWS Instance Resource for Build server
resource "aws_instance" "Build_server" {
  ami           = "ami-0bb84b8ffd87024d8"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.Build_SG.id]

  tags = {
    Name = "Build_server"
  }
}
# AWS Security Group Resource for Build server
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
  tags = {
    Name = "Build_SG"
  }
}
####Deployment server with functionality of Docker
#AWS Instance Resource for Deployment  server
resource "aws_instance" "Deployment_server" {
  ami           = "ami-0bb84b8ffd87024d8"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.Deployment_SG.id]
    tags = {
    Name = "Deployment_server"
  }
}
#Private ip interface
resource "aws_network_interface" "private" {
    subnet_id = "subnet-0513abf3db97a734c"
    private_ips = ["172.31.22.10"]
    }
    
resource "aws_network_interface_attachment" "private_attachment" {
    instance_id = aws_instance.Deployment_server.id
    device_index = 1
    network_interface_id = aws_network_interface.private.id
  }
# AWS Security Group Resource for Deployment  server
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
  tags = {
    Name = "Deployment_SG"
  }
}
##AWS Instance Resource for Ansible  server
resource "aws_instance" "Ansible_server" {
  ami           = "ami-0bb84b8ffd87024d8"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.Ansible_SG.id]

  tags = {
    Name = "Ansible_server"
  }
}
# AWS Security Group Resource for Ansible server
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

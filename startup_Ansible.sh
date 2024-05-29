#!/bin/bash
sudo yum install -y ansible
sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
echo "PermitRootLogin yes" | sudo tee -a /etc/ssh/sshd_config
sudo sed -i 's/^PermitEmptyPasswords no/PermitEmptyPasswords yes/' /etc/ssh/sshd_config
sudo chpasswd <<<"ec2-user:ec2-user"
sudo systemctl reload sshd
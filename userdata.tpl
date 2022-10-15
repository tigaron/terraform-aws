#!/bin/bash
yum -y update &&
yum -y install git docker &&
service docker start &&
usermod -aG docker ec2-user &&
chkconfig docker on &&
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose &&
sudo chmod +x /usr/local/bin/docker-compose &&
reboot
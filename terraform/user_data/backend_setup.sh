#!/bin/bash

yum update -y

yum install docker git -y

systemctl enable docker

systemctl start docker

curl -L \
"https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-linux-x86_64" \
-o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

usermod -aG docker ec2-user

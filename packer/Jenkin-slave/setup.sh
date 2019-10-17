#!/bin/bash

echo "Install Java JDK 8"
yum remove -y java
yum install -y java-1.8.0-openjdk

echo "Install git"
yum install -y git

echo "Install node-js"

sudo yum update –y
mkdir /app
chmod 755 /app
cd /app
git clone https://github.com/opsworkshop/node-hello.git
curl -sL https://rpm.nodesource.com/setup_6.x | sudo -E bash -
sudo yum install nodejs --enablerepo=nodesource -y
cd /app/opsworkshop/node-hello
npm install
npm start

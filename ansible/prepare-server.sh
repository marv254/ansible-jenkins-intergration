#!/usr/bin/env bash

sudo yum update
sudo yum install ansible -y
sudo yum install python3-pip -y
pip3 install boto3 botocore

# export AWS_ACCESS_KEY_ID=$1
# export AWS_SECRET_ACCESS_KEY=$2


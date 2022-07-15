#!/usr/bin/env bash

sudo apt update
sudo apt install ansible -y
sudo apt install python3-pip -y
pip3 install boto3 botocore

# export AWS_ACCESS_KEY_ID=$1
# export AWS_SECRET_ACCESS_KEY=$2


#!/bin/bash
sudo apt update
sudo apt upgrade

#install python and pip
sudo apt install -y python3
sudo apt install -y python3-pip

#create a virtual env
sudo apt install python3-venv
python3 -m venv venv
source venv/bin/activate

# Install Flask and boto3
pip install Flask
pip install boto3

# Create app directory
mkdir /home/ubuntu/app
cd /home/ubuntu/app

# Download the app script from S3 (or use any method to bring app.py to the instance)
# Assuming you have uploaded app.py to S3 or GitHub
wget https:github.com/kaivalya-bachkar/Project/app/app.py.git -O app.py

#configure flask to run in production
pip install gunicorn
gunicorn --bind 0.0.0.0:5000 app:app

# Start Flask app
nohup python3 app.py &

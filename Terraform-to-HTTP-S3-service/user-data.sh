#!/bin/bash
sudo apt-get update -y

# Install Docker to Run the container
sudo apt install -y docker.io

# To Start the Docker Service
sudo service docker start

# To Give the Permission to a Docker
sudo chown $USER /var/run/docker.sock

# To Run the container
docker run -p 5000:5000 -e AWS_ACCESS_KEY_ID=<your_access_key> -e AWS_SECRET_ACCESS_KEY=<your_secret_key> kaivalyabachkar/devops:latest

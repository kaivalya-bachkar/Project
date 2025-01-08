# This project consists of two parts:

1.	HTTP Service: A Python-based HTTP service that lists the contents of an S3 bucket.

2.	Terraform Deployment: Infrastructure as Code (IaC) using Terraform to deploy the HTTP service on AWS.

## HTTP Service:-

Installed the following Services to run A Python-based HTTP service:

- Python 3
- AWS CLI configured with valid credentials
- Docker
- An AWS S3 bucket for testing

### Application Setup:

a. Create the Python HTTP Service

b. Create the Dockerfile

### Running Locally with Docker

- Build the Docker Image:
  
  ```bash
   docker build -t myimg .
   ```

- Run the Docker Container:

   ```bash
   docker run -p 5000:5000 -e AWS_ACCESS_KEY_ID=<AWS_ACCESS_KEY> -e AWS_SECRET_ACCESS_KEY=<AWS_SECRET_KEY> myimg
   ```
c.	Test the Service Locally:

### Open a browser or use curl to test the endpoints:
    curl http://localhost:5000/list-bucket-content
    curl http://localhost:5000/list-bucket-content/dir1
    
## Terraform Deployment:
   
- Installed Terraform on your machine.
- Terraform Infrastructure Setup.

### a.	Create Terraform Files:
- aws_provider.tf: This providers a plugin responsible for interacting with APIs to create, manage, and destroy resources.
- main.tf: This file defines the AWS resources (EC2 instance, security groups, etc.).
- variables.tf: Defines variables used in the Terraform configuration.
- outputs.tf: Defines outputs, such as the EC2 instance's public IP.
- User-data.sh: The user data field is used within the aws instance resource to pass the shell script
  
### b.Initialize and Apply Terraform:

- Initialize the working directory:

  ```bash
   terraform init
   ```
    
- Apply the Terraform configuration:
  
   ```bash
   terraform apply
   ```
    
- Confirm the changes, and Terraform will provision an EC2 instance and deploy the app.

### Testing the Application:

After Terraform completes, the public IP of the EC2 instance will be displayed. You can use this IP to test the service:
   
    curl http://<EC2_PUBLIC_IP>:5000/list-bucket-content
    curl http://<EC2_PUBLIC_IP>:5000/list-bucket-content/dir1

You should see the content of the S3 bucket in the JSON format, as described in the assignment.

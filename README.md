# Backend Deployment Assessment

Infrastructure provisioning and containerization of the MuchTodo Golang backend using **Terraform**, **Docker**, **Docker Compose**, and **AWS**.

---

# Project Overview

This project provisions the cloud infrastructure required to host the MuchTodo backend application on AWS using Terraform.

The backend application is containerized using Docker and deployed with Docker Compose alongside a MongoDB database.

The deployed architecture includes:

- AWS VPC
- Public and Private Subnets
- Bastion Host
- Backend EC2 Instance
- MongoDB EC2 Instance
- Application Load Balancer
- Security Groups
- Dockerized Backend
- Docker Compose Deployment

---

# Architecture

```
                 Internet
                     │
                     ▼
        Application Load Balancer
                     │
                     ▼
            Backend EC2 Instance
                     │
                     ▼
             MongoDB EC2 Instance

          Bastion Host (SSH Access)
```

The Bastion Host is deployed in a public subnet and provides secure SSH access to the Backend EC2 instance, which resides in a private subnet. The Backend communicates with the MongoDB server through private networking, while external users access the application through the Application Load Balancer.

---

# Repository Structure

```
backend-deployment-assessment/

├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tfvars.example
│   └── user_data/
│       ├── backend_setup.sh
│       └── mongodb_setup.sh
│
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
├── evidence/
└── README.md
```

---

# Prerequisites

Before running this project, ensure the following tools are installed:

- AWS CLI
- Terraform
- Docker
- Docker Compose
- Git

You also need:

- An AWS account
- IAM credentials with permissions to create AWS infrastructure

---

# Clone the Repository

```bash
git clone https://github.com/Blessedinho/backend-deployment-assessment.git

cd backend-deployment-assessment
```

---

# Configure AWS CLI

```bash
aws configure
```

Enter:

- AWS Access Key
- AWS Secret Access Key
- Default Region (e.g. us-east-1)
- Output Format (json)

---

# Terraform Deployment

## Initialize Terraform

```bash
cd terraform

terraform init
```

---

## Validate Configuration

```bash
terraform validate
```

---

## Preview Infrastructure

```bash
terraform plan
```

---

## Provision Infrastructure

```bash
terraform apply
```

Type:

```
yes
```

when prompted.

---

## View Terraform Outputs

```bash
terraform output
```

Outputs include:

- VPC ID
- ALB DNS Name
- Bastion Public IP
- Backend Private IP

---

# Infrastructure Created

Terraform provisions:

- Custom VPC
- Internet Gateway
- NAT Gateway
- Route Tables
- Two Public Subnets
- Two Private Subnets
- Bastion Host
- Backend EC2 Instance
- MongoDB EC2 Instance
- Security Groups
- Application Load Balancer
- Target Group
- Listener

---

# Docker Build

Navigate to the application directory:

```bash
cd ../much-to-do/Server/MuchToDo
```

Build the Docker image:

```bash
docker build -t muchtodo-backend .
```

---

# Docker Compose

Start the services:

```bash
docker compose up -d
```

Verify containers:

```bash
docker ps
```

---

# Local Health Check

Verify the backend is healthy:

```bash
curl http://localhost:8080/health
```

Expected response:

```json
{
  "cache":"disabled",
  "database":"ok"
}
```

---

# Deployment on AWS

## SSH into Bastion Host

```bash
ssh -i ~/.ssh/alt_school.pem ec2-user@<BASTION_PUBLIC_IP>
```

---

## SSH into Backend Server

```bash
ssh ec2-user@<BACKEND_PRIVATE_IP>
```

---

## Clone the Backend Repository

```bash
git clone https://github.com/Innocent9712/much-to-do.git
```

Navigate into the project:

```bash
cd much-to-do/Server/MuchToDo
```

---

## Start Containers

```bash
docker compose up -d
```

Verify:

```bash
docker ps
```

---

## Backend Health Check

```bash
curl http://localhost:8080/health
```

---

## Verify Through the Application Load Balancer

Retrieve the ALB DNS Name:

```bash
terraform output alb_dns_name
```

Then verify:

```bash
curl http://<ALB_DNS_NAME>/health
```

Example:

```bash
curl http://backend-alb-xxxxxxxx.us-east-1.elb.amazonaws.com/health
```

Expected Response:

```json
{
  "cache":"disabled",
  "database":"ok"
}
```

---

# Terraform Variables

| Variable | Description |
|----------|-------------|
| aws_region | AWS Region |
| instance_type | EC2 Instance Type |
| my_ip | Current Public IP |
| project_name | Project Name |

---

# Terraform Outputs

| Output | Description |
|---------|-------------|
| vpc_id | Created VPC ID |
| alb_dns_name | Application Load Balancer DNS |
| bastion_public_ip | Bastion Host Public IP |
| backend_private_ip | Backend Server Private IP |

---

# Cleanup

Destroy all infrastructure:

```bash
terraform destroy
```

---

# Evidence

Deployment screenshots are located in:

```
evidence/
```

The screenshots include:

1. Terraform Initialization
2. Terraform Plan
3. Terraform Apply
4. VPC
5. Subnets
6. Security Groups
7. EC2 Instances
8. ALB & Target Group
9. Docker Build
10. Docker Compose
11. Local Health Check
12. SSH through Bastion
13. Docker Compose on Backend EC2
14. ALB Health Check

---

# Technologies Used

- Terraform
- AWS EC2
- AWS VPC
- AWS ALB
- Docker
- Docker Compose
- MongoDB
- Golang
- Git
- Linux

---

# Lessons Learned

During this assessment I gained hands-on experience with:

- Provisioning AWS infrastructure using Infrastructure as Code (Terraform).
- Designing secure networking using public/private subnets and Security Groups.
- Deploying highly available infrastructure with an Application Load Balancer.
- Building optimized Docker images using multi-stage builds.
- Running containerized applications with Docker Compose.
- Deploying a Golang backend connected to MongoDB.
- Using a Bastion Host to securely access private EC2 instances.
- Validating application health using Docker HEALTHCHECK and ALB health checks.
- Managing cloud infrastructure through reusable Terraform configurations.

---

# Author

**Eddie (Blessedinho)**

Backend Deployment Assessment – AltSchool Africa Cloud Engineering Program

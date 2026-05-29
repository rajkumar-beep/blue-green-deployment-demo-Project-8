# Blue-Green Deployment Demo using AWS, Terraform & Docker

## Project Overview

This project demonstrates a production-style Blue-Green Deployment architecture on AWS using Terraform, Auto Scaling Groups, Docker and Application Load Balancer concepts.

The objective of this project is to understand:

* Infrastructure provisioning using Terraform
* Multi-AZ architecture
* Launch Templates
* Auto Scaling Groups
* Docker container deployment
* Blue-Green deployment concepts
* Traffic switching strategies
* Zero downtime deployment

---

# Topology Diagram

```text id="w9hdf6"
                           INTERNET
                               |
                        Internet Gateway
                               |
                    Application Load Balancer
                               |
              -----------------------------------
              |                                 |
              v                                 v

                    TARGET GROUP - BLUE
              --------------------------------
              |                              |
              v                              v

      Blue EC2-1 (AZ-1a)            Blue EC2-2 (AZ-1b)
         Docker App v1                 Docker App v1

              -----------------------------------
                               |
                         Auto Scaling Group
                               |


                    TARGET GROUP - GREEN
              --------------------------------
              |                              |
              v                              v

     Green EC2-1 (AZ-1a)          Green EC2-2 (AZ-1b)
         Docker App v2                Docker App v2

              -----------------------------------
                               |
                         Auto Scaling Group


============================================================

VPC : 10.0.0.0/16

Public Subnets:
- 10.0.1.0/24 (ap-south-1a)
- 10.0.3.0/24 (ap-south-1b)

Private Subnets:
- 10.0.2.0/24 (ap-south-1a)
- 10.0.4.0/24 (ap-south-1b)
```

---

# Current Project Status

## Completed

* VPC creation using Terraform
* Public and Private subnet creation
* Internet Gateway setup
* NAT Gateway setup
* Route Table configuration
* Security Group configuration
* Launch Template creation
* Auto Scaling Group setup
* EC2 automatic provisioning
* Docker container deployment

## In Progress

* Application Load Balancer setup
* Target Groups configuration
* Blue-Green traffic switching
* CI/CD automation

---

# Architecture

## VPC Configuration

| Resource | CIDR        |
| -------- | ----------- |
| VPC      | 10.0.0.0/16 |

---

## Availability Zones

| AZ          |
| ----------- |
| ap-south-1a |
| ap-south-1b |

---

## Subnet Design

| Subnet     | CIDR        | AZ          |
| ---------- | ----------- | ----------- |
| Public-1a  | 10.0.1.0/24 | ap-south-1a |
| Private-1a | 10.0.2.0/24 | ap-south-1a |
| Public-1b  | 10.0.3.0/24 | ap-south-1b |
| Private-1b | 10.0.4.0/24 | ap-south-1b |

---

# Infrastructure Workflow

## Step 1 — Terraform Infrastructure

Terraform was used to provision:

* VPC
* Subnets
* Internet Gateway
* NAT Gateway
* Route Tables
* Security Groups

---

## Step 2 — Launch Template Creation

Launch Templates were created to automate:

* EC2 provisioning
* Docker installation
* Application deployment

---

## Step 3 — Auto Scaling Groups

Two Auto Scaling Groups were created:

* Blue ASG
* Green ASG

Each ASG deploys EC2 instances across multiple Availability Zones.

---

## Step 4 — Docker Deployment

Docker containers were deployed on EC2 instances using userdata scripts.

---

# Deployment Scenarios

## Scenario 1 — Standard Blue-Green Deployment

Initially all traffic goes to Blue Environment:

```bash id="1r1xzf"
100% Traffic → Blue Environment
```

After successful deployment and validation:

```bash id="kpk4fk"
100% Traffic → Green Environment
```

This approach provides:

* Zero downtime deployment
* Safe release strategy
* Instant rollback capability

---

## Scenario 3 — Weighted Traffic Distribution

Both Blue and Green environments run across multiple Availability Zones.

### Blue Environment

| Instance | AZ          |
| -------- | ----------- |
| Blue-1   | ap-south-1a |
| Blue-2   | ap-south-1b |

### Green Environment

| Instance | AZ          |
| -------- | ----------- |
| Green-1  | ap-south-1a |
| Green-2  | ap-south-1b |

If ALB weighted routing is configured:

```bash id="6mkigw"
50% Traffic → Blue
50% Traffic → Green
```

Then traffic distribution becomes:

```bash id="krrwzn"
Blue-1   → 25%
Blue-2   → 25%
Green-1  → 25%
Green-2  → 25%
```

This strategy is commonly used in:

* Canary deployments
* Gradual production rollout
* Production testing

---

# Project Structure

```bash id="1bd30m"
blue-green-deployment-demo-Project-8/
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── docker-app/
│   ├── Dockerfile
│   └── app.py
│
├── screenshots/
│   ├── ALB/
│   ├── ASG/
│   ├── blue-green-switch/
│   ├── Docker/
│   ├── Launch-template/
│   ├── SG/
│   ├── terraform/
│   └── VPC/
```

---

# Screenshots

Project screenshots are organized phase-wise:

* Terraform
* VPC
* Security Groups
* Launch Templates
* ASG
* Docker
* ALB
* Blue-Green Switching

---

# Future Improvements

* Complete ALB integration
* Target Group configuration
* Blue-Green traffic switching
* CI/CD using GitHub Actions
* Monitoring & Logging
* HTTPS integration

---

# Technologies Used

* AWS
* Terraform
* Docker
* Linux
* Auto Scaling Group
* Application Load Balancer
* GitHub

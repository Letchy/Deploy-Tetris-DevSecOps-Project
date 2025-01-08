# Tetris Kubernetes & CI/CD Pipeline Project

This project demonstrates use of modern DevOps tooling to deploy the Tetris application to an Amazon EKS cluster, incorporating DevSecOps best practices for overall security and automation.
<!--  https://medium.com/@navidehbaghaifar/how-to-install-jenkins-on-an-ec2-with-terraform-d5e9ed3cdcd9

This project is designed to deploy a Tetris game application on an EKS cluster (Amazon EC2), incorporating best practices for security and automation.

- Setup backend using Amazon S3 to store the terraform state file, configured dynamodb for state locking. This maintains integrity of the state file and integrity of the infrastructure especially when collaborating as part of a team.

aws dynamodb create-table `
--table-name terraform-lock-table `
--attribute-definitions AttributeName=LockID,AttributeType=S `
--key-schema AttributeName=LockID,KeyType=HASH `
--provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 `
--region eu-west-2

- Variables.tf file added to ensure nothing is hardcoded into the main.tf file

- Created IAM user named "Jenkins-admin" and applied custom policy I created to give read/write access to the S3 bucket.

https://docs.aws.amazon.com/transfer/latest/userguide/users-policies-all-access.html

- Deployed Jenkins to an EC2 instance (AWS)  -->
## Overview

The pipeline includes:

- **Terraform**: Automates the provisioning of an Amazon EKS cluster for Kubernetes workloads.
- **Trivy**: Ensures security by scanning file systems and container images for vulnerabilities.
- **SonarQube**: Performs static code analysis to detect bugs, vulnerabilities, and code smells.
- **Docker**: Builds and hosts containerised applications for deployment.
- **Kubernetes**: Manages and deploys containerised workloads efficiently.
<!-- - **Falco**: Monitors runtime behaviour to detect anomalies and potential security threats in Kubernetes clusters. -->

## Highlights

- **Infrastructure as Code**:  
  - Uses Terraform to provision an Amazon EKS cluster, ensuring consistent and repeatable infrastructure deployment.

- **Security-First Approach**:  
  - Vulnerability scanning with Trivy integrated at multiple stages of the pipeline.  
  <!-- - Runtime security monitoring with Falco to detect unauthorised or suspicious activity in the cluster. -->

- **Code Quality Assurance**:  
  - Ensures clean, maintainable, and reliable code using SonarQube.

- **Seamless Containerisation**:  
  - Leverages Docker for consistent and reproducible application builds.

- **Kubernetes Integration**:  
  - Deploys scalable, containerised applications using Kubernetes manifests.

## Tools and Technologies

- **Infrastructure**: Terraform, Amazon EKS, AWS  
- **CI/CD**: GitHub Actions, Jenkins, or similar tools (configurable)  
- **Security**: Trivy, <!-- Falco -->  
- **Code Quality**: SonarQube  
- **Containerisation**: Docker  
- **Orchestration**: Kubernetes

## Use Cases

This pipeline is ideal for:

- Automating infrastructure provisioning and application deployment in cloud-native environments.
- Enhancing security and code quality in the software development lifecycle.
- Monitoring runtime behaviour for threats and anomalies in Kubernetes clusters.
- Demonstrating DevOps expertise in CI/CD pipeline design, infrastructure automation, and runtime security.

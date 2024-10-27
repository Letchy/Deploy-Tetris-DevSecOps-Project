# Deploy-Tetris-DevSecOps-Project

This project is designed to deploy a Tetris game application on an EKS cluster (Amazon EC2), incorporating best practices for security and automation.

# Deploy-Tetris-DevSecOps-Project

<-- https://medium.com/@navidehbaghaifar/how-to-install-jenkins-on-an-ec2-with-terraform-d5e9ed3cdcd9 -->

# This project is designed to deploy a Tetris game application on an EKS cluster (Amazon EC2), incorporating best practices for security and automation.

# Setup backend using Amazon S3 to store the terraform state file, configured dynamodb for state locking. This maintains integrity of the state file and integrity of the infrastructure especially when collaborating as part of a team.

<!-- aws dynamodb create-table `
--table-name terraform-lock-table `
--attribute-definitions AttributeName=LockID,AttributeType=S `
--key-schema AttributeName=LockID,KeyType=HASH `
--provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 `
--region eu-west-2 -->

# Variables.tf file added to ensure nothing is hardcoded into the main.tf file

# Created IAM user named "Jenkins-admin" and applied custom policy I created to give read/write access to the S3 bucket.

<!-- https://docs.aws.amazon.com/transfer/latest/userguide/users-policies-all-access.html -->

# Deployed Jenkins to an EC2 instance (AWS)

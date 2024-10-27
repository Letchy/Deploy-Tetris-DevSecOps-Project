#!/bin/bash
set -e  # Exit the script if any command fails

# Detect package manager
if command -v apt >/dev/null 2>&1; then
    PACKAGE_MANAGER="apt"
    UPDATE_COMMAND="sudo apt update -y"
    INSTALL_COMMAND="sudo apt install -y"
elif command -v yum >/dev/null 2>&1; then
    PACKAGE_MANAGER="yum"
    UPDATE_COMMAND="sudo yum update -y"
    INSTALL_COMMAND="sudo yum install -y"
else
    echo "Unsupported package manager."
    exit 1
fi

# Update the package repository
$UPDATE_COMMAND

# Installing Java
$INSTALL_COMMAND openjdk-17-jre
$INSTALL_COMMAND openjdk-17-jdk
java --version

# Installing Jenkins
if [ "$PACKAGE_MANAGER" = "apt" ]; then
    curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
      /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
      https://pkg.jenkins.io/debian binary/ | sudo tee \
      /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update -y
    $INSTALL_COMMAND jenkins
else
    echo "Jenkins installation is currently supported for Debian-based distributions only."
fi

# Installing Docker
$UPDATE_COMMAND
$INSTALL_COMMAND docker.io
sudo usermod -aG docker jenkins || true  # Ignore error if jenkins user doesn't exist
sudo usermod -aG docker ec2-user || true # Use ec2-user if the instance runs Amazon Linux
sudo systemctl restart docker || true
sudo chmod 777 /var/run/docker.sock || true

# Run Docker Container of Sonarqube
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community || true

# Installing AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
$INSTALL_COMMAND unzip
unzip awscliv2.zip
sudo ./aws/install || true

# Installing Kubectl
$UPDATE_COMMAND
$INSTALL_COMMAND curl
curl -LO "https://dl.k8s.io/release/v1.28.4/bin/linux/amd64/kubectl"
sudo chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --client || true

# Installing Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
$UPDATE_COMMAND
$INSTALL_COMMAND terraform

# Installing Trivy
$INSTALL_COMMAND wget gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
$UPDATE_COMMAND
$INSTALL_COMMAND trivy

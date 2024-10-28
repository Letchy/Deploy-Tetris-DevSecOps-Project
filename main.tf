# Create Jenkins Security Group Resource 
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_security_group"
  description = "Allow SSH and HTTP traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH access from anywhere (be cautious with this in production)
  }

  ingress {
    from_port   = 8080 # Port for Jenkins
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow access to Jenkins from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Creates an S3 bucket which is used specifically for Jenkins artifacts
resource "aws_s3_bucket" "bkletch_tetris_s3" {

  tags = {
    Name = "Jenkins-tetris-server"
  }
}

# Apply ownership controls to the S3 bucket
resource "aws_s3_bucket_ownership_controls" "bkletch_tetris_s3_controls" {
  bucket = aws_s3_bucket.bkletch_tetris_s3.id # Correctly reference the bucket

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Sets the S3 bucket to private so public access is not possible, access control list (ACL) is used to manage access
resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.bkletch_tetris_s3_controls] # Make sure this waits for the bucket to be created

  bucket = aws_s3_bucket.bkletch_tetris_s3.id # Correctly reference the bucket
  acl    = "private"
}

# Creates an IAM role that allows S3 read/write access for the Jenkins server and assigns this role to the EC2 instance

resource "aws_iam_role" "tetris-s3-jenkins-role" {
  name = "s3-jenkins_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com" #service level Access
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "tetris-s3-jenkins-policy" {
  name   = "s3-jenkins-rw-policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "S3ReadWriteAccess",
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::bkletch-tetris-s3",
        "arn:aws:s3:::bkletch-tetris-s3/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "tetris-s3-jenkins-access" {
  policy_arn = aws_iam_policy.tetris-s3-jenkins-policy.arn
  role       = aws_iam_role.tetris-s3-jenkins-role.name
}

resource "aws_iam_instance_profile" "tetris-s3-jenkins-profile" {
  name = "s3-jenkins-profile"
  role = aws_iam_role.tetris-s3-jenkins-role.name
}

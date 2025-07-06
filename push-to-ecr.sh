#!/bin/bash

REGION=us-east-1

# 📝 Get AWS account ID dynamically
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

echo "Using AWS Account ID: $AWS_ACCOUNT_ID"

# 🚀 Login to ECR
echo "Logging in to ECR..."
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com

# 🚀 Build and push backend
echo "Building backend image..."
docker build -t flower-backend ./backend
docker tag flower-backend:latest $AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/flower-backend:latest
docker push $AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/flower-backend:latest

# 🚀 Build and push frontend
echo "Building frontend image..."
docker build -t flower-frontend ./frontend
docker tag flower-frontend:latest $AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/flower-frontend:latest
docker push $AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/flower-frontend:latest

echo "✅ Push complete!"

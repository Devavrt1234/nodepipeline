#!/bin/bash

# Variables
REGION="us-east-1"
ACCOUNT_ID="565393066140"
REPO_NAME="my-node-now-app"
IMAGE_NAME="$REPO_NAME:latest"


# Step 1: Authenticate Docker to ECR
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com

# Step 2: Build the Docker image
docker build -t $IMAGE_NAME .

# Step 3: Tag the image for ECR
docker tag $IMAGE_NAME $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPO_NAME:latest

# Step 4: Push the image to ECR
docker push $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPO_NAME:latest

# Step 6: Pull the Docker image on EC2
sudo docker pull $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPO_NAME:latest

# Step 7: Run the Docker container
sudo docker run -d --name devavrat -p 3000:3000 $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPO_NAME:latest


echo "Deployment complete."

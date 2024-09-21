#!/bin/bash

# Variables
REGION="us-east-1"
REPO_NAME="node-app-image"
IMAGE_NAME="$REPO_NAME:latest"
CONTAINER_NAME="my-node-app"  # Name of the container
PORT="3000"  # Port to expose

# Step 1: Authenticate Docker to ECR
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin public.ecr.aws/q4p9o7t9

# Step 2: Build the Docker image
docker build -t $IMAGE_NAME .

# Step 3: Tag the image for ECR
echo "tagging Docker image on ECR..."
docker tag node-app-image:latest public.ecr.aws/q4p9o7t9/node-app-image:latest

# Step 4: Push the image to ECR
docker push public.ecr.aws/q4p9o7t9/node-app-image:latest

# Step 6: Pull the Docker image on EC2
sudo docker pull public.ecr.aws/q4p9o7t9/node-app-image:latest

# Step 7: Run the Docker container
sudo docker run -d --name my-node-app -p 3000:3000 public.ecr.aws/q4p9o7t9/node-app-image:latest
ENDSSH

echo "Deployment complete."


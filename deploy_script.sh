#!/bin/bash

# Variables
REGION="eu-north-1"
REPO_NAME="node-repo"
IMAGE_NAME="$REPO_NAME:latest"
CONTAINER_NAME="my-node-app"  # Name of the container
PORT="3000"  # Port to expose

# Step 1: Authenticate Docker to ECR
#aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin public.ecr.aws/q4p9o7t9
aws ecr get-login-password --region eu-north-1 | docker login --username AWS --password-stdin 565393066140.dkr.ecr.eu-north-1.amazonaws.com
# Step 2: Build the Docker image
docker build -t $IMAGE_NAME .


# Step 3: Tag the image for ECR
echo "tagging Docker image on ECR..."
#docker tag node-app-image:latest public.ecr.aws/q4p9o7t9/node-app-image:latest
docker tag node-repo:latest 565393066140.dkr.ecr.eu-north-1.amazonaws.com/node-repo:latest
# Step 4: Push the image to ECR
#docker push public.ecr.aws/q4p9o7t9/node-app-image:latest
docker push 565393066140.dkr.ecr.eu-north-1.amazonaws.com/node-repo:latest
# Step 6: Pull the Docker image on EC2
docker 565393066140.dkr.ecr.eu-north-1.amazonaws.com/node-repo:latest

# Step 7: Run the Docker container
docker run -d --name my-node-app -p 3000:3000 565393066140.dkr.ecr.eu-north-1.amazonaws.com/node-repo:latest


echo "Deployment complete."


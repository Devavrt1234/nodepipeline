#!/bin/bash

# Define variables
REGION="us-east-1"  # AWS region
ACCOUNT_ID="565393066140"  # Your AWS account ID
REPOSITORY_NAME="node-repo"  # ECR repository name
IMAGE_TAG="latest"  # Tag of the image you want to pull
CONTAINER_NAME="my-node-app"  # Name of the container
PORT="81"  # Port to expose

# Function to authenticate and pull Docker image from ECR
function push_pull_and_run_image {
    echo "Authenticating Docker to ECR..."
    aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/q4p9o7t9
    
    docker build -t node-app-image .
  
    echo "tagging Docker image on ECR..."
    docker tag node-app-image:latest public.ecr.aws/q4p9o7t9/node-app-image:latest

    docker push public.ecr.aws/q4p9o7t9/node-app-image:latest
    
    echo "Pulling Docker image from ECR..."
    docker pull $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPOSITORY_NAME/node-app-image:$IMAGE_TAG

    echo "Running Docker container..."
    docker run -d --name $CONTAINER_NAME -p $PORT:$PORT $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPOSITORY_NAME:$IMAGE_TAG
}

# Execute function
push_pull_and_run_image

# List all containers, including stopped ones
echo "All containers:"
docker ps -a

# Retrieve the container name
CONTAINER_NAME=$(docker ps -f name=$CONTAINER_NAME -q)

# Print the container name
echo "Container name: $CONTAINER_NAME"

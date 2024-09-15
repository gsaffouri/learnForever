#!/bin/bash

# Set variables
IMAGE_NAME="nginx:latest"
CONTAINER_NAME="nginx_web_server"
HOST_PORT=8080
CONTAINER_PORT=80
WEB_DIR="website"

# Create a directory for the website if it doesn't exist
mkdir -p $WEB_DIR

# Create a simple index.html file
cat <<EOF > $WEB_DIR/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Web App</title>
</head>
<body>
    <h1>Hello from George Saffouris Dockerized Web Application :)!</h1>
</body>
</html>
EOF

# Pull the latest Nginx image
echo "Pulling Nginx Docker image..."
docker pull $IMAGE_NAME

# Stop and remove any existing container with the same name
echo "Stopping and removing any existing container named $CONTAINER_NAME..."
docker stop $CONTAINER_NAME 2>/dev/null
docker rm $CONTAINER_NAME 2>/dev/null

# Run a new Nginx container, mapping the website directory
echo "Running the Nginx container..."
docker run -d --name $CONTAINER_NAME \
    -p $HOST_PORT:$CONTAINER_PORT \
    -v $(pwd)/$WEB_DIR:/usr/share/nginx/html:ro \
    $IMAGE_NAME

# Output success message
echo "Web server running at http://localhost:$HOST_PORT"

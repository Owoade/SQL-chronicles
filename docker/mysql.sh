#!/bin/bash

# MySQL Docker Login Script
# Usage: ./mysql_login.sh <container-name> <username>

# Check if correct number of arguments provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <container-name> <username>"
    echo "Example: $0 my-mysql-container root"
    exit 1
fi

CONTAINER_NAME="$1"
USERNAME="$2"

echo "Connecting to MySQL container '$CONTAINER_NAME' as user '$USERNAME'..."

# Execute the command
docker exec -it "$CONTAINER_NAME" mysql -u "$USERNAME" -p
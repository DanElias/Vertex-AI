#!/bin/bash

# Script to copy files/directories from Jupyter to a Google Cloud Storage bucket

# Bucket Path 
BUCKET_PATH="gs://backup/backups"  # Replace with your actual bucket path

# Source directory 
SOURCE_DIR="/home/jupyter/*"   # Copies all contents from the Jupyter directory

# Check if gsutil is installed 
if ! command -v gsutil &> /dev/null
then
    echo "gsutil command not found. Please install the Google Cloud SDK."
    exit 1
fi

# Run the gsutil copy command 
gsutil cp -R "$SOURCE_DIR" "$BUCKET_PATH"

# Check for errors 
if [ $? -eq 0 ]
then
    echo "Files copied successfully to $BUCKET_PATH"
else
    echo "An error occurred during the copy process."
    exit 1
fi

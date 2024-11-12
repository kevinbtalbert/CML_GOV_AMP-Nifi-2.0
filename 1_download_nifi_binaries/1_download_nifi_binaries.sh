#!/bin/bash

# Define variables
NIFI_VERSION="2.0.0"
NIFI_URL="https://dlcdn.apache.org/nifi/$NIFI_VERSION/nifi-$NIFI_VERSION-source-release.zip"
DOWNLOAD_DIR="$HOME/nifi_download"
UNPACK_DIR="$HOME/nifi_source"

# Create download and unpack directories if they do not exist
mkdir -p "$DOWNLOAD_DIR"
mkdir -p "$UNPACK_DIR"

# Download NiFi source zip file
echo "Downloading NiFi $NIFI_VERSION from $NIFI_URL..."
curl -o "$DOWNLOAD_DIR/nifi-$NIFI_VERSION-source-release.zip" "$NIFI_URL"

# Check if download was successful
if [[ $? -ne 0 ]]; then
    echo "Download failed. Please check the URL or your network connection."
    exit 1
fi

echo "Download completed successfully."

# Unzip the NiFi source
echo "Unpacking NiFi to $UNPACK_DIR..."
unzip "$DOWNLOAD_DIR/nifi-$NIFI_VERSION-source-release.zip" -d "$UNPACK_DIR"

# Check if unzip was successful
if [[ $? -ne 0 ]]; then
    echo "Unzipping failed. Please ensure the file is a valid zip archive."
    exit 1
fi

echo "NiFi unpacked successfully to $UNPACK_DIR."

# Cleanup downloaded zip file (optional)
# rm "$DOWNLOAD_DIR/nifi-$NIFI_VERSION-source-release.zip"

# Script completed
echo "Setup completed."

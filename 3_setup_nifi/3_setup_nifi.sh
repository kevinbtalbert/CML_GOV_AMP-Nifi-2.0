#!/bin/bash

JAVA_VER="21.0.1"
export JAVA_VER="21.0.1"
export JAVA_HOME="/home/cdsw/java-21/jdk-${JAVA_VER}"

# Define variables
NIFI_HOME="$HOME/nifi_source/nifi-2.0.0"  # Update this path if NiFi is located elsewhere
NIFI_USER="admin"
NIFI_PASSWORD="Supersecret1"

# Check for required environment variables
if [[ -z "$CDSW_APP_PORT" ]]; then
  echo "Error: CDSW_APP_PORT environment variable is not set."
  exit 1
fi

# Navigate to NiFi directory
cd "$NIFI_HOME" || { echo "NiFi home directory not found"; exit 1; }

# Set single-user credentials for NiFi
echo "Setting up NiFi admin user with provided credentials..."
./bin/nifi.sh set-single-user-credentials "$NIFI_USER" "$NIFI_PASSWORD"

# Update essential properties in nifi.properties
NIFI_PROPERTIES="$NIFI_HOME/conf/nifi.properties"
echo "Configuring essential parameters in nifi.properties..."

# Configure network port and host using environment variables
sed -i "s/^nifi.web.https.host=.*/nifi.web.https.host=127.0.0.1/" "$NIFI_PROPERTIES"
sed -i "s/^nifi.web.https.port=.*/nifi.web.https.port=$CDSW_APP_PORT/" "$NIFI_PROPERTIES"

# Set NiFi to auto-generate a self-signed certificate (dev environments only)
sed -i 's/nifi.security.autogenerate.sensitive.keys=false/nifi.security.autogenerate.sensitive.keys=true/' "$NIFI_PROPERTIES"

# Set backpressure parameters (adjust based on processing needs)
sed -i 's/nifi.queue.backpressure.size.threshold=1 GB/nifi.queue.backpressure.size.threshold=5 GB/' "$NIFI_PROPERTIES"
sed -i 's/nifi.queue.backpressure.count.threshold=10000/nifi.queue.backpressure.count.threshold=20000/' "$NIFI_PROPERTIES"

# Confirm setup completion
echo "NiFi setup completed with user 'admin' and custom settings."
echo "To start NiFi, run the nifi_start.sh script."

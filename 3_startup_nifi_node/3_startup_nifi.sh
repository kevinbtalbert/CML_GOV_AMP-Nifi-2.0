#!/bin/bash

# Define variables
NIFI_HOME="$HOME/nifi_source/nifi-2.0.0"  # Update this path if NiFi is located elsewhere

# Check if NiFi directory exists
if [[ ! -d "$NIFI_HOME" ]]; then
  echo "NiFi home directory not found at $NIFI_HOME"
  exit 1
fi

# Start NiFi as a background service
echo "Starting NiFi..."
cd "$NIFI_HOME" && ./bin/nifi.sh start --wait-for-init 120

# Confirm start
echo "NiFi started. Access it at https://127.0.0.1:$CDSW_APP_PORT/nifi."

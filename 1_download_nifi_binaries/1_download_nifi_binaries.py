import subprocess
import requests
import zipfile
import os

# Define the URL and paths
nifi_url = "https://dlcdn.apache.org/nifi/2.0.0/nifi-2.0.0-bin.zip"
download_path = "/home/cdsw/nifi-2.0.0-bin.zip"
extract_path = "/home/cdsw/nifi_source"

# Download NiFi
print(f"Downloading NiFi 2.0.0 from {nifi_url}...")
response = requests.get(nifi_url, stream=True)
if response.status_code == 200:
    with open(download_path, "wb") as file:
        for chunk in response.iter_content(chunk_size=8192):
            file.write(chunk)
    print("Download completed successfully.")
else:
    print(f"Failed to download NiFi. Status code: {response.status_code}")
    exit(1)

# Unpack the NiFi zip file
if os.path.isfile(download_path):
    print(f"Unpacking NiFi to {extract_path}...")
    os.makedirs(extract_path, exist_ok=True)
    with zipfile.ZipFile(download_path, 'r') as zip_ref:
        zip_ref.extractall(extract_path)
    print("Unpacking completed successfully.")
else:
    print("Download file not found.")

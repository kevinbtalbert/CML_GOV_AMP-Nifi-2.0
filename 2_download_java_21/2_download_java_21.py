import os
import requests
import tarfile

# Set Java version and paths
JAVA_VER = "21.0.1"
BASE_DIR = "/home/cdsw/java-21"
JAVA_HOME = f"{BASE_DIR}/jdk-{JAVA_VER}"
JAVA_TGZ = f"openjdk-{JAVA_VER}_linux-x64_bin.tar.gz"
JAVA_DL_URL = f"https://download.java.net/java/GA/jdk{JAVA_VER}/415e3f918a1f4062a0074a2794853d0d/12/GPL/{JAVA_TGZ}"

# Create the java-21 directory if it doesn't already exist
os.makedirs(BASE_DIR, exist_ok=True)

# Download Java with progress indication
tgz_path = os.path.join(BASE_DIR, JAVA_TGZ)
print(f"Downloading Java {JAVA_VER} from {JAVA_DL_URL}...")
with requests.get(JAVA_DL_URL, stream=True) as response:
    response.raise_for_status()
    with open(tgz_path, 'wb') as file:
        for chunk in response.iter_content(chunk_size=8192):
            file.write(chunk)
            # Print a dot for progress indication
            print(".", end="", flush=True)

print("\nDownload completed.")

# Extract the tar.gz file directly to JAVA_HOME if it exists
if os.path.isfile(tgz_path):
    print(f"Extracting Java {JAVA_VER} to {JAVA_HOME}...")
    with tarfile.open(tgz_path, "r:gz") as tar:
        tar.extractall(path=BASE_DIR)
    os.rename(os.path.join(BASE_DIR, f"jdk-{JAVA_VER}"), JAVA_HOME)  # Rename to ensure correct path
    os.remove(tgz_path)
    print(f"Java {JAVA_VER} installed at {JAVA_HOME}")
else:
    print("Download failed or file not found.")

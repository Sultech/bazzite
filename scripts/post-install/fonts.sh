#!/bin/bash

# Define variables
DOWNLOAD_URL="https://drive.usercontent.google.com/download?id=1s-wZF91THCjhbcTPHA-vClX5U7lxSAsa&export=download&confirm=t&uuid=717bb140-fcf0-454e-a369-f3a3ad5cfabe"
DEST_DIR="/home/$USER/.local/share"
TEMP_FILE="downloaded_file.zip"  # Change the extension if the file is not a zip

# Create the destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Download the file
echo "Downloading file..."
curl -L -o "$TEMP_FILE" "$DOWNLOAD_URL"

# Check if the download was successful
if [[ $? -ne 0 ]]; then
    echo "Download failed!"
    exit 1
fi

# Extract the file
echo "Extracting file..."
unzip -o "$TEMP_FILE" -d "$DEST_DIR"

# Check if extraction was successful
if [[ $? -ne 0 ]]; then
    echo "Extraction failed!"
    exit 1
fi

# Remove the temporary downloaded file
rm "$TEMP_FILE"

# Grant Flatpak permission to the folder
flatpak override --filesystem=/home/$USER/.local/share/fonts

echo "Download, extraction, and permission granting complete."


#!/bin/bash

# Define variables
DOWNLOAD_URL="https://drive.usercontent.google.com/download?id=1q6RvhqliXbZQ_TaO47mwmfpA8oSUW7fE&export=download&authuser=0&confirm=t&uuid=a2680cde-1ffa-4bc4-b077-3a3763b2f25a"
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
sudo flatpak override --filesystem=/home/$USER/.local/share/fonts

echo "Download, extraction, and permission granting complete."


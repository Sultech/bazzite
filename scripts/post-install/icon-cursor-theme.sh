#!/bin/bash

# Define variables
URL="https://github.com/Sultech/bazzite/raw/refs/heads/main/icons/Reversal-blue.tar.xz"
CURSOR_URL="https://raw.githubusercontent.com/Sultech/bazzite/refs/heads/main/icons/Bibata-Modern-Ice.tar.xz"
DEST_DIR="/home/$USER/.icons"
TEMP_FILE="Reversal-blue.tar.xz"
TEMP_CURSOR_FILE="Bibata-Modern-Ice.tar.xz"
THEME_NAME="Reversal-blue-dark"  # Change this if necessary
CURSOR_THEME_NAME="Bibata-Modern-Ice"  # Change this if necessary

# Create the destination directory if it doesn't exist
if [ ! -d "$DEST_DIR" ]; then
    echo "Creating directory $DEST_DIR..."
    mkdir -p "$DEST_DIR"
fi

# Download the icon theme
echo "Downloading icons from $URL..."
wget -q $URL -O $TEMP_FILE

# Check if the download was successful
if [ $? -ne 0 ]; then
    echo "Failed to download icon file."
    exit 1
fi

# Extract the downloaded icon theme
echo "Extracting $TEMP_FILE..."
tar -xf $TEMP_FILE -C "$DEST_DIR"

# Check if extraction was successful
if [ $? -ne 0 ]; then
    echo "Failed to extract icon file."
    rm $TEMP_FILE
    exit 1
fi

# Clean up icon temp file
rm $TEMP_FILE
echo "Icons installed successfully to $DEST_DIR."

# Download the cursor theme
echo "Downloading cursor theme from $CURSOR_URL..."
wget -q $CURSOR_URL -O $TEMP_CURSOR_FILE

# Check if the download was successful
if [ $? -ne 0 ]; then
    echo "Failed to download cursor file."
    exit 1
fi

# Extract the downloaded cursor theme
echo "Extracting $TEMP_CURSOR_FILE..."
tar -xf $TEMP_CURSOR_FILE -C "$DEST_DIR"

# Check if extraction was successful
if [ $? -ne 0 ]; then
    echo "Failed to extract cursor file."
    rm $TEMP_CURSOR_FILE
    exit 1
fi

# Clean up cursor temp file
rm $TEMP_CURSOR_FILE
echo "Cursor theme installed successfully to $DEST_DIR."

# Apply the icon theme
echo "Setting the icon theme to $THEME_NAME..."
gsettings set org.gnome.desktop.interface icon-theme "$THEME_NAME"

# Check if the command was successful
if [ $? -eq 0 ]; then
    echo "Icon theme set successfully to $THEME_NAME."
else
    echo "Failed to set the icon theme."
fi

# Apply the cursor theme
echo "Setting the cursor theme to $CURSOR_THEME_NAME..."
gsettings set org.gnome.desktop.interface cursor-theme "$CURSOR_THEME_NAME"

# Check if the command was successful
if [ $? -eq 0 ]; then
    echo "Cursor theme set successfully to $CURSOR_THEME_NAME."
else
    echo "Failed to set the cursor theme."
fi

# Grant Flatpak permission to the icon and cursor theme folder
echo "Giving Flatpak permission to the icons directory..."
flatpak override --user --filesystem="$DEST_DIR"

# Check if the command was successful
if [ $? -eq 0 ]; then
    echo "Flatpak permission granted successfully."
else
    echo "Failed to grant Flatpak permission."
fi

# Exit script
exit 0


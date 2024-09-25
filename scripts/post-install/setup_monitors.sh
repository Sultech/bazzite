#!/bin/bash

# Define the URL to download
URL="https://raw.githubusercontent.com/Sultech/bazzite/refs/heads/main/scripts/post-install/MonitorSetup.zip"

# Define the output filename and extraction directory
OUTPUT="MonitorSetup.zip"
EXTRACTION_DIR="/home/$USER/Documents/MonitorSetup"
APPLICATIONS_DIR="/home/$USER/.local/share/applications"

# Download the file using curl
echo "Downloading $OUTPUT from $URL..."
curl -L -o "$OUTPUT" "$URL"

# Check if the download was successful
if [[ $? -eq 0 ]]; then
    echo "Download completed successfully!"
    
    # Create the extraction directory if it doesn't exist
    mkdir -p "$EXTRACTION_DIR"
    
    # Extract the ZIP file
    echo "Extracting $OUTPUT to $EXTRACTION_DIR..."
    unzip -o "$OUTPUT" -d "$EXTRACTION_DIR"
    
    # Check if extraction was successful
    if [[ $? -eq 0 ]]; then
        echo "Extraction completed successfully!"
        
        # Make the scripts executable
        echo "Making MainMonitorLeft.sh and MainMonitorRight.sh executable..."
        chmod +x "$EXTRACTION_DIR/MainMonitorLeft.sh" "$EXTRACTION_DIR/MainMonitorRight.sh"

        # Check if the chmod command was successful
        if [[ $? -eq 0 ]]; then
            echo "Scripts made executable successfully!"
        else
            echo "Error: Failed to make scripts executable."
        fi
        
        # Copy .desktop files to the applications directory
        echo "Copying Windows.desktop and Linux.desktop to $APPLICATIONS_DIR..."
        cp "$EXTRACTION_DIR/Windows.desktop" "$APPLICATIONS_DIR/"
        cp "$EXTRACTION_DIR/Linux.desktop" "$APPLICATIONS_DIR/"

        # Check if the copy command was successful
        if [[ $? -eq 0 ]]; then
            echo ".desktop files copied successfully!"
        else
            echo "Error: Failed to copy .desktop files."
        fi
        
        # Delete the original ZIP file
        echo "Deleting the original ZIP file..."
        rm "$OUTPUT"
        
        echo "Cleanup completed."

        # Bind the scripts to custom keybindings
        echo "Setting custom keybindings for MainMonitorLeft.sh and MainMonitorRight.sh..."
        gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom1/']"

        # Bind MainMonitorLeft.sh to KP /
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom0/ name 'Main Monitor Left'
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom0/ command "$EXTRACTION_DIR/MainMonitorLeft.sh"
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom0/ binding 'KP_Divide'

        # Bind MainMonitorRight.sh to KP *
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom1/ name 'Main Monitor Right'
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom1/ command "$EXTRACTION_DIR/MainMonitorRight.sh"
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom1/ binding 'KP_Multiply'

        echo "Keybindings set successfully!"
    else
        echo "Error: Extraction failed."
    fi
else
    echo "Error: Download failed."
fi


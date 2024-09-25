#!/bin/bash

# Install the undervolt package from GitHub
echo "Installing undervolt from GitHub..."
sudo pip install git+https://github.com/georgewhewell/undervolt.git

# Check if the installation was successful
if [ $? -eq 0 ]; then
    echo "Installation successful!"

    # Enable the undervolt service
    echo "Enabling undervolt service..."
    sudo systemctl enable undervolt

    # Start the undervolt service (optional)
    echo "Starting undervolt service..."
    sudo systemctl start undervolt

    echo "Undervolt service enabled and started."
else
    echo "Installation failed."
    exit 1
fi

#!/bin/bash

# Define the target file
ENV_FILE="/etc/environment"

# Remove the existing /etc/environment file if it exists
if [ -f "$ENV_FILE" ]; then
    echo "Deleting existing $ENV_FILE..."
    rm -f "$ENV_FILE"
fi

# Create a new /etc/environment file and add the specified lines
echo "Creating $ENV_FILE and adding the specified lines..."
{
    echo "# https://gitlab.gnome.org/GNOME/mutter/-/issues/3037"
    echo "MUTTER_DEBUG_KMS_THREAD_TYPE=user"
    echo "# Disable Brew auto-update"
    echo "HOMEBREW_NO_AUTO_UPDATE=1"
    echo "XMODIFIERS=@im=none"
    echo "GSK_RENDERER=ngl"
    echo "__GLX_VENDOR_LIBRARY_NAME=nvidia"
    echo "__NV_PRIME_RENDER_OFFLOAD=1"
    echo "__VK_LAYER_NV_optimus=NVIDIA_only"
} > "$ENV_FILE"

echo "$ENV_FILE has been created and configured."

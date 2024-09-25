#!/bin/bash

# Define the lines to append
LINES_TO_APPEND=(
    "# https://gitlab.gnome.org/GNOME/mutter/-/issues/3037"
    "MUTTER_DEBUG_KMS_THREAD_TYPE=user"
    "# Disable Brew auto-update"
    "HOMEBREW_NO_AUTO_UPDATE=1"
    "XMODIFIERS=@im=none"
    "GSK_RENDERER=ngl"
    "__GLX_VENDOR_LIBRARY_NAME=nvidia"
    "__NV_PRIME_RENDER_OFFLOAD=1"
    "__VK_LAYER_NV_optimus=NVIDIA_only"
)

# Function to append lines
append_line() {
    local line="$1"
    if ! grep -Fxq "$line" /etc/environment; then
        echo "$line" >> /etc/environment
        echo "Appended: $line"
    else
        echo "The line already exists: $line"
    fi
}

# Loop through each line and append it
for line in "${LINES_TO_APPEND[@]}"; do
    append_line "$line"
done

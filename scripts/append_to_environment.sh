#!/bin/bash

# Define the lines to append
LINES_TO_APPEND=(
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
        echo "$line" | sudo tee -a /etc/environment > /dev/null
        echo "Appended: $line"
    else
        echo "The line already exists: $line"
    fi
}

# Loop through each line and append it
for line in "${LINES_TO_APPEND[@]}"; do
    append_line "$line"
done


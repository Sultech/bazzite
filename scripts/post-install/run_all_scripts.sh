#!/bin/bash

# Array of script URLs
scripts=(
    "https://raw.githubusercontent.com/Sultech/bazzite/refs/heads/main/scripts/post-install/setup_monitors.sh"
    "https://raw.githubusercontent.com/Sultech/bazzite/refs/heads/main/scripts/post-install/icon-cursor-theme.sh"
    "https://raw.githubusercontent.com/Sultech/bazzite/refs/heads/main/scripts/post-install/fonts.sh"
    "https://raw.githubusercontent.com/Sultech/bazzite/refs/heads/main/scripts/post-install/install_and_enable_undervolt.sh"
    "https://raw.githubusercontent.com/Sultech/bazzite/refs/heads/main/scripts/post-install/install_flatpaks.sh"  # Second to last
    "https://raw.githubusercontent.com/Sultech/bazzite/refs/heads/main/scripts/post-install/update_kargs.sh"      # Last
)

# Download and execute each script
for url in "${scripts[@]}"; do
    script_name=$(basename "$url")
    echo "Downloading $script_name..."
    wget -q "$url" -O "$script_name"

    if [[ $? -eq 0 ]]; then
        echo "Running $script_name..."
        chmod +x "$script_name"
        ./"$script_name"  # Run without sudo
    else
        echo "Failed to download $script_name. Skipping..."
    fi
done

echo "All scripts have been executed."


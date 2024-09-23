# Custom image of Bazzite-Gnome-Nvidia

# Changes 

Adds Docker Repo and installs these packages:

docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

Removes wireplumber and installs the pipewire-media-session package.

Enables Virtualization and installs virt-manager

# Rebase Command

    rpm-ostree rebase ostree-image-signed:docker://ghcr.io/sultech/bazzite:latest

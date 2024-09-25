#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# Remove packages
dnf remove wireplumber -y

# add docker repo, installing packages, adding service to fix docker in distrobox 
curl -Lo /etc/yum.repos.d/docker-ce.repo https://download.docker.com/linux/fedora/docker-ce.repo
rpm-ostree install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin pipewire-media-session
systemctl enable docker
mkdir /usr/local/lib
curl -Lo /usr/local/lib/docker-fix.sh https://raw.githubusercontent.com/Sultech/bazzite/refs/heads/main/scripts/docker-fix.sh
curl -Lo /etc/systemd/system/docker-permission-fix.service https://raw.githubusercontent.com/Sultech/bazzite/refs/heads/main/scripts/docker-permission-fix.service
systemctl enable docker-permission-fix

# installing virtualization packages
rpm-ostree install -y virt-manager edk2-ovmf qemu libvirt
systemctl enable bazzite-libvirtd-setup.service

# installing undervolt not enabled by default
pip install git+https://github.com/georgewhewell/undervolt.git
curl -Lo /etc/systemd/system/undervolt.service https://raw.githubusercontent.com/Sultech/bazzite/refs/heads/main/scripts/undervolt.service

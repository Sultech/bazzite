#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# Remove packages
# dnf remove wireplumber -y

rpm-ostree install hyprland-devel

# add docker repo, installing packages, adding service to fix docker in distrobox 
curl -Lo /etc/yum.repos.d/docker-ce.repo https://download.docker.com/linux/fedora/docker-ce.repo
rpm-ostree install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin #pipewire-media-session dotnet-sdk-8.0 aspnetcore-runtime-8.0 dotnet-runtime-8.0 gcc selinux-policy-targeted #yaru-theme gnome-shell-extension-pop-shell 
systemctl enable docker
mkdir /etc/scripts/
curl -Lo /etc/scripts/docker-fix.sh https://raw.githubusercontent.com/Sultech/bazzite/refs/heads/main/scripts/docker-fix.sh
chmod +x /etc/scripts/docker-fix.sh
curl -Lo /etc/systemd/system/docker-permission-fix.service https://raw.githubusercontent.com/Sultech/bazzite/refs/heads/main/scripts/docker-permission-fix.service
systemctl enable docker-permission-fix

# installing virtualization packages
rpm-ostree install -y virt-manager edk2-ovmf qemu libvirt
systemctl enable bazzite-libvirtd-setup.service

#curl -Lo /etc/scripts/append_to_environment.sh https://raw.githubusercontent.com/Sultech/bazzite/refs/heads/main/scripts/append_to_environment.sh
#chmod +x /etc/scripts/append_to_environment.sh
#cd /etc/scripts/
#./append_to_environment.sh

#rpm-ostree install fuse squashfuse snapd
#ln -s /var/lib/snapd/snap /snap

# installing undervolt not enabled by default
# pip install git+https://github.com/georgewhewell/undervolt.git
# curl -Lo /etc/systemd/system/undervolt.service https://raw.githubusercontent.com/Sultech/bazzite/refs/heads/main/scripts/undervolt.service
# systemctl enable undervolt

#HyprLand
curl -Lo /etc/yum.repos.d/solopasha-hyprland-fedora-41.repo https://copr.fedorainfracloud.org/coprs/solopasha/hyprland/repo/fedora-41/solopasha-hyprland-fedora-41.repo
rpm-ostree install hyprland-git hyprpaper hyprlock hypridle xdg-desktop-portal-hyprland waybar-git pavucontrol kitty fontawesome-6-free-fonts hyprland-plugins-git rofi-wayland waypaper hyprsunset cmake meson cpio pkg-config


#git clone https://github.com/LGFae/swww.git
#cd swww
#cargo build --release

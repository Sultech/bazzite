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
#curl -Lo /etc/yum.repos.d/solopasha-astal-fedora-41.repo https://copr.fedorainfracloud.org/coprs/solopasha/astal/repo/fedora-41/solopasha-astal-fedora-41.repo
#curl -Lo /etc/yum.repos.d/peterwu-rendezvous-fedora-41.repo https://copr.fedorainfracloud.org/coprs/peterwu/rendezvous/repo/fedora-41/peterwu-rendezvous-fedora-41.repo
#rpm-ostree install hyprland-git hyprpaper hyprlock hypridle noto-fonts xdg-desktop-portal-hyprland libnotify dunst kitty qt5-qtwayland qt6-qtwayland waybar-git waypaper pavucontrol  fontawesome-6-free-fonts  rofi-wayland waypaper hyprsunset cmake meson cpio pkg-config udis86 udis86-devel
#rpm-ostree install hyprland hyprpaper hyprlock hypridle google-noto-sans-fonts xdg-desktop-portal-hyprland libnotify dunst kitty qt5-qtwayland qt6-qtwayland fastfetch xdg-desktop-portal-gtk eza python-pip python3-gobject tumbler brightnessctl nm-connection-editor network-manager-applet fuse ImageMagick jq xclip kitty neovim htop pinta blueman grim slurp cliphist nwg-look qt6ct waybar-git rofi-wayland zsh fzf pavucontrol papirus-icon-theme plasma-breeze gvfs wlogout waypaper astal bibata-cursor-themes fontawesome-6-free-fonts mozilla-fira-sans-fonts fira-code-fonts NetworkManager-tui
#rpm-ostree install wget zip unzip gum rsync git figlet sed vim xdg-user-dirs man-pages python3-pip
rpm-ostree install hyprland hyprlock hypridle hyprsunset hyprpolkitagent hyprshot cliphist waypaper google-noto-sans-fonts xdg-desktop-portal-hyprland libnotify dunst kitty qt5-qtwayland qt6-qtwayland fastfetch xdg-desktop-portal-gtk network-manager-applet brightnessctl nwg-look waybar-git rofi-wayland pavucontrol fontawesome-6-free-fonts
#pip install pywalfox
#pip install pywal
#pip install screeninfo
#wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /var/usrlocal/bin/oh-my-posh
#chmod +x /var/usrlocal/bin/oh-my-posh
#git clone https://github.com/LGFae/swww.git
#cd swww
#cargo build --release

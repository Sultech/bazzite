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

# add repo 
curl -Lo /etc/yum.repos.d/docker-ce.repo https://download.docker.com/linux/fedora/docker-ce.repo

# this installs a package from fedora repos
rpm-ostree install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin pipewire-media-session

rpm-ostree install -y virt-manager edk2-ovmf qemu libvirt
rpm-ostree kargs \
--append-if-missing="kvm.ignore_msrs=1" \
--append-if-missing="kvm.report_ignored_msrs=0"
sudo systemctl enable bazzite-libvirtd-setup.service

# this would install a package from rpmfusion
# rpm-ostree install vlc

#### Example for enabling a System Unit File Test

systemctl enable docker

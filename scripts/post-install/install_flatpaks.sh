#!/bin/bash

# Update Flatpak
echo "Updating Flatpak..."
sudo flatpak update -y

# Install each Flatpak application
echo "Installing Flatpak applications..."
sudo flatpak install flathub io.github.ungoogled_software.ungoogled_chromium -y
sudo flatpak install flathub com.discordapp.Discord -y
sudo flatpak install flathub org.telegram.desktop -y
sudo flatpak install flathub com.usebottles.bottles -y
sudo flatpak install flathub com.heroicgameslauncher.hgl -y
sudo flatpak install flathub com.stremio.Stremio -y
sudo flatpak install flathub org.remmina.Remmina -y
flatpak override com.usebottles.bottles --filesystem=/home/$USER/.var/app/com.heroicgameslauncher.hgl/config/heroic/tools/proton

echo "All specified Flatpak applications have been installed."


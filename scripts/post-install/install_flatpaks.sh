#!/bin/bash

# Update Flatpak
# echo "Updating Flatpak..."
# sudo flatpak update -y

Install each Flatpak application
echo "Installing Flatpak applications..."
flatpak install --system flathub io.github.ungoogled_software.ungoogled_chromium -y
flatpak install --system flathub com.discordapp.Discord -y
flatpak install --system flathub org.telegram.desktop -y
flatpak install --system flathub com.usebottles.bottles -y
flatpak install --system flathub com.heroicgameslauncher.hgl -y
flatpak install --system flathub com.stremio.Stremio -y
flatpak install --system flathub org.remmina.Remmina -y
flatpak install --system flathub com.wps.Office -y
sudo flatpak override com.usebottles.bottles --filesystem=/home/$USER/.var/app/com.heroicgameslauncher.hgl/config/heroic/tools/proton
sudo flatpak override com.usebottles.bottles --filesystem=xdg-data/applications
sudo flatpak override io.github.dvlv.boxbuddyrs --filesystem=home
python3 -m venv maestral-venv
source maestral-venv/bin/activate
python3 -m pip install --upgrade maestral
python3 -m pip install --upgrade 'maestral[gui]'
gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'


echo "All specified Flatpak applications have been installed."


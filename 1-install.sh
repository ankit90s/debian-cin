#!/bin/bash

## check for sudo/root
if ! [ $(id -u) = 0 ]; then
  echo -e "\e[1;31m Please run as sudo or root \e[0m"
  exit 1
fi

# Copy Source file
echo -e "\e[1;32m Copying sources.list file \e[0m"
mv /etc/apt/sources.list /etc/apt/sources.list.bkp
cp sources.list /etc/apt/sources.list
apt update && apt upgrade -y

# Get username
username=$(id -u -n 1000)

# install cinnamon
echo -e "\e[1;32m Installing cinnamon desktop \e[0m"
apt install -y cinnamon-core

# PDF viewer
echo -e "\e[1;32m Installing Document viewer \e[0m"
apt install -y evince

# image viewer
echo -e "\e[1;32m Installing Image viewer \e[0m"
apt install -y gpicview

# cursor
echo -e "\e[1;32m Installing cursor themes \e[0m"
apt install -y bibata-cursor-theme dmz-cursor-theme

# terminal of choice
echo -e "\e[1;32m Installing terminal \e[0m"
apt install -y alacritty

# onboard keyboard
echo -e "\e[1;32m Installing onscreen keyboard \e[0m"
apt install -y onboard

# setup starship
echo -e "\e[1;32m Installing starship shell prompt \e[0m"
wget https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-musl.tar.gz
tar -xvzf starship-x86_64-unknown-linux-musl.tar.gz
mv starship /usr/local/bin
rm starship-x86_64-unknown-linux-musl.tar.gz

# Browser
echo -e "\e[1;32m Installing firefox-esr \e[0m"
apt install -y firefox-esr

# Download Managers
echo -e "\e[1;32m Installing download managers \e[0m"
apt install -y curl wget axel aria2

# Applications and utilities
echo -e "\e[1;32m Installing apps and utilities \e[0m"
apt install -y git pip ranger cmatrix espeak ncdu translate-shell rsync kdeconnect yt-dlp gpick

# Dictionary
echo -e "\e[1;32m Installing gnome-dictionary \e[0m"
apt install -y gnome-dictionary

# clipboard
apt install -y diodon

# Torrent Management
echo -e "\e[1;32m Installing torrent-client/transmission \e[0m"
apt install -y transmission

# sensors
echo -e "\e[1;32m Installing sensors \e[0m"
apt install -y lm-sensors

# Archiving tools
echo -e "\e[1;32m Installing archiving tools \e[0m"
apt install -y zip unzip p7zip-full

# search applications
echo -e "\e[1;32m Installing rofi and dmenu \e[0m"
apt install -y rofi dmenu

# System Monitors
echo -e "\e[1;32m Installing conky nefetch htop \e[0m"
apt install -y conky neofetch htop

# Calculator
echo -e "\e[1;32m Installing calculator \e[0m"
apt install -y qalculate-gtk

# redshift
echo -e "\e[1;32m Installing redshift \e[0m"
apt install -y redshift

# mintstick
echo -e "\e[1;32m Installing mint stick \e[0m"
apt install -y mintstick

# Media Player
apt install -y mpv

# setup starship
echo -e "\e[1;32m Installing starship shell prompt \e[0m"
wget https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-musl.tar.gz
tar -xvzf starship-x86_64-unknown-linux-musl.tar.gz
mv starship /usr/local/bin
rm starship-x86_64-unknown-linux-musl.tar.gz

# copy bashrc and bash_aliases
echo -e "\e[1;32m Installing bashrc and bash aliases \e[0m"
cp bashrc /home/$username/.bashrc
cp bash_aliases /home/$username/.bash_aliases

# mkdir
echo -e "\e[1;32m Creating directory ISO in home folder \e[0m"
mkdir /home/$username/ISOs
chown $username:$username /home/$username/*

# install slick greeter
echo -e "\e[1;32m Installing slick greeter \e[0m"
apt install -y slick-greeter lightdm-gtk-greeter-settings lightdm-settings numlockx
rm -rf /etc/lightdm
cp -r settings/lightdm /etc

# Copy grub file
echo -e "\e[1;32m Installing grub cfg file \e[0m"
rm /etc/default/grub
cp settings/grub /etc/default
update-grub

echo 
echo -e "\e[1;32m Rebooting now \e[0m"
sleep 2s
reboot

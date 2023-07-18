#!/bin/bash

## check for sudo/root
if ! [ $(id -u) = 0 ]; then
  echo -e "\e[1;31m Please run as sudo or root \e[0m"
  exit 1
fi

# Get username
username=$(id -u -n 1000)

# Restricted extras
echo -e "\e[1;32m Installing restricted extras \e[0m"
apt install -y ttf-mscorefonts-installer rar unrar libavcodec-extra gstreamer1.0-libav gstreamer1.0-plugins-ugly gstreamer1.0-vaapi

# Network File Tools/System Events
echo -e "\e[1;32m Network File Tools and System Events \e[0m"
apt install -y dialog mtools dosfstools avahi-daemon acpi acpid gvfs-backends locate mtp-tools

systemctl enable avahi-daemon
systemctl enable acpid

# Mesa and vulkan support
echo -e "\e[1;32m Installing mesa and vulkan support \e[0m"
apt install -y mesa-vulkan-drivers libvulkan1 vulkan-tools vulkan-validationlayers

# install build tools
echo -e "\e[1;32m Installing build tools \e[0m"
apt install -y build-essential linux-headers-$(uname -r) intel-microcode

# libreoffice install
echo -e "\e[1;32m Installing libreoffice and its themes \e[0m"
apt install -y libreoffice-gtk3 libreoffice-impress libreoffice-calc libreoffice-writer
apt install -y libreoffice-style*

# Text editor
echo -e "\e[1;32m Installing geany, micro and neovim \e[0m"
apt install -y geany micro neovim
git clone https://github.com/VundleVim/Vundle.vim.git /home/$username/.vim/bundle/Vundle.vim

# pfetch
echo -e "\e[1;32m Installing pfetch \e[0m"
git clone https://github.com/dylanaraps/pfetch.git
cd pfetch
install pfetch /usr/local/bin
cd ..
rm -rf pfetch

# Goolge Chrome
echo -e "\e[1;32m Installing google chrome \e[0m"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# fast-cli
echo -e "\e[1;32m Installing fast-cli for Internet speed test \e[0m"
wget https://github.com/ddo/fast/releases/download/v0.0.4/fast_linux_amd64 -O fast
chmod +x fast
mv fast /usr/local/bin

# ani-cli
echo -e "\e[1;32m Installing ani-cli for anime lovers \e[0m"
git clone "https://github.com/pystardust/ani-cli.git"
install ani-cli/ani-cli /usr/local/bin
rm -rf ani-cli

# config files
echo -e "\e[1;32m Copying config files \e[0m"
cd /home/$username
git clone https://github.com/ankit90s/dotconfig && cd dotconfig
cp -r * /home/$username/.config
chown -R $username:$username /home/$username
cd $builddr

echo 
echo -e "\e[1;32m Rebooting now \e[0m"
sleep 2s
reboot

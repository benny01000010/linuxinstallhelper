#!/usr/bin/env bash

# This file, when executed, will promt you to install the following helpful tools/application on your Linux system:
#sudo, curl, ffmpeg, git, nmap, ufw, wget, docker, and vim. 

#Please run this script as root, or use "sudo" if you've already installed it. 
# If you have already installed sudo on your system, make sure to run sudo bash ./installscript in order to prevent errors.

#To auto install all packages at once, append "-y" or "--yes" to the end of your command to execute this script. More details can be found in the README.md file.

echo -e "\e[32m Welcome to linuxinstallhelper script... \e[0m"
echo -e "\e[91m This script is intended for Debian based distributions. \e[0m"\
echo -e "\e[91m If you are not running DEBIAN/UBUNTU Linux, please Ctrl+C and use the correct script for your distro! \e[0m"

printf '\033[34m'

cat <<'EOF'
    ____  _                             ___  _  ___   ___   ___   ___  _  ___  
   / __ \| |__   ___ _ __  _ __  _   _ / _ \/ |/ _ \ / _ \ / _ \ / _ \/ |/ _ \ 
  / / _` | '_ \ / _ \ '_ \| '_ \| | | | | | | | | | | | | | | | | | | | | | | |
 | | (_| | |_) |  __/ | | | | | | |_| | |_| | | |_| | |_| | |_| | |_| | | |_| |
  \ \__,_|_.__/ \___|_| |_|_| |_|\__, |\___/|_|\___/ \___/ \___/ \___/|_|\___/ 
   \____/ __     __ _(_) |_| |__ |___/_| |__                                   
  / _ \| '_ \   / _` | | __| '_ \| | | | '_ \                                  
 | (_) | | | | | (_| | | |_| | | | |_| | |_) |                                 
  \___/|_| |_|  \__, |_|\__|_| |_|\__,_|_.__/                                  
                |___/                                                          
EOF

printf '\033[0m'

echo -e "\e[32m Updating and upgrading existing packages...\e[0m"
apt update
apt upgrade -y

echo -e "\e[91m To install all packages AT ONCE, Ctrl+C then re-execute this script with the --yes or -y flag. \e[0m"
echo -e "\e[91m Otherwise, you will be prompted for each package installation. Proceed with caution! \e[0m"
echo -e "\e[91m Continuing with PROMPTED package installer in 5.. \e[0m"
sleep 1
echo -e "\e[91m 4.. \e[0m"
sleep 1
echo -e "\e[91m 3.. \e[0m"
sleep 1
echo -e "\e[91m 2.. \e[0m"
sleep 1
echo -e "\e[91m 1.. \e[0m"
sleep 1

AUTO_YES=false
if [[ "$1" == "--yes" || "$1" == "-y" ]]; then
    AUTO_YES=true
fi

ask_install() {
    pkg_name=$1
    install_cmd=$2

    if $AUTO_YES; then
        echo -e "\e[32m Auto-installing all packages. \e[0m"
        echo "Installing $pkg_name..."
        eval "$install_cmd"
    else
        read -p "Install $pkg_name? (Y/n) " choice
        choice=${choice:-Y}
        if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
            echo "Installing $pkg_name..."
            eval "$install_cmd"
        else
            echo "Skipping $pkg_name."
        fi
    fi
}

echo -e "\e[32m Autoremoving packages that are no longer needed... \e[0m"
apt autoremove -y

# Apt packages
ask_install "sudo" "apt install sudo -y"
ask_install "curl" "apt install curl -y"
ask_install "ffmpeg" "apt install ffmpeg -y"
ask_install "nmap" "apt install nmap -y"
ask_install "git" "apt install git -y"
ask_install "ufw" "apt install ufw -y"
ask_install "wget" "apt-get install wget -y"
ask_install "vim" "apt install vim -y"
ask_isntall "nfs" "apt install nfs -y"
ask_install "samba" "apt install samba -y"
ask_install "docker" "apt install docker -y"

echo -e "\e[32m All selected packages have been installed successfully. Thank you for using linuxinstallhelper!\e[0m"

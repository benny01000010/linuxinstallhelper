#!/usr/bin/env bash

# Please run this script as root, or use "sudo" if you've already installed it. 
# If you have already installed sudo on your system, make sure to run sudo bash ./redhat.sh in order to prevent errors.

#To auto install all packages at once, append "-y" or "--yes" to the end of your command to execute this script. More details can be found in the README.md file.

echo -e "\e[32m Welcome to linuxinstallhelper script... \e[0m"
echo -e "\e[91m This script is intended for Red Hat based distributions. \e[0m"
echo -e "\e[91m If you are not running RED HAT Linux, please Ctrl+C and use the correct script for your distro! \e[0m"
sleep 1
echo -e "\e[91m This script is compatible with Red Hat Enterprise Linux (RHEL) versions 8 and later. \e[0m"
sleep 1

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

dnf update -y

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
    echo -e "\e[32m Auto-installing all packages... \e[0m"
fi

ask_install() {
    pkg_name=$1
    install_cmd=$2

    if $AUTO_YES; then
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
dnf autoremove -y

# Apt packages
ask_install "epel-release" "dnf install epel-release -y"
ask_install "sudo" "dnf install sudo -y"
ask_install "curl" "dnf install curl -y"
ask_install "nmap" "dnf install nmap -y"
ask_install "git" "dnf install git -y"
ask_install "firewalld" "dnf install firewalld -y"
ask_install "wget" "dnf install wget -y"
ask_install "vim" "dnf install vim -y"
ask_install "nfs-utils" "dnf install nfs-utils -y"
ask_install "samba" "dnf install samba-client -y"
ask_install "podman" "dnf install podman -y"
ask_install "rsync" "dnf install rsync -y"
ask_install "net-tools" "dnf install net-tools -y"
ask_install "openssh-server" "dnf install openssh-server -y"
ask_install "htop" "dnf install htop -y"
ask_install "tree" "dnf install tree -y"
ask_install "iotop" "dnf install iotop -y"
ask_install "lsof" "dnf install lsof -y"

echo -e "\e[32m All selected packages have been installed successfully. Thank you for using linuxinstallhelper!\e[0m"

#!/usr/bin/env bash

# Please run this script as root, or use "sudo" if you've already installed it. 
# If you have already installed sudo on your system, make sure to run sudo bash ./debian.sh in order to prevent errors.

# To auto install all packages at once, append "-y" or "--yes" to the end of your command to execute this script. More details can be found in the README.md file.

# A full list of packages that will be installed by this script can be found in the README.md file.


echo -e "\e[34m Welcome to linuxinstallhelper script... \e[0m"
echo -e "\e[33m This script is intended for Debian based distributions. \e[0m" # Compatibility information and warning
echo -e "\e[33m If you are not running DEBIAN/UBUNTU Linux, please Ctrl+C and use the correct script for your distro! \e[0m"
echo -e "\e[33m This script is compatible with Debian 8 and later as well as Ubuntu 16.04 and later. \e[0m"
sleep 3

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

sleep 1

if [[ $EUID -ne 0 ]]; then # Checks to see if script is run as root or with sudo
   echo -e "\e[91m This script must be run as root or with sudo. Exiting... \e[0m" 
   exit 1
fi

echo -e "\e[33m Updating and upgrading existing packages...\e[0m" # Self explanatory
apt update
apt upgrade -y
echo -e "\e[33m Removing unnecessary packages...\e[0m"
apt autoremove -y


AUTO_YES=false  # Determine if auto-install flag is used
for arg in "$@"; do
    if [[ "$arg" == "--yes" || "$arg" == "-y" ]]; then
        AUTO_YES=true
        break
    fi
done

if [[ "$AUTO_YES" = true ]]; then 
    echo -e "\e[32m Auto-installing all packages... \e[0m" && sleep 2
else
    echo -e "\e[33m To install all packages AT ONCE, Ctrl+C then re-execute this script with the --yes or -y flag. \e[0m"
    echo -e "\e[33m Otherwise, you will be prompted for each package installation. Proceed with caution! \e[0m"
    echo -e "\e[33m Continuing with PROMPTED package installer in 5.. \e[0m"
    sleep 1
    echo -e "\e[33m 4.. \e[0m"
    sleep 1
    echo -e "\e[33m 3.. \e[0m"
    sleep 1
    echo -e "\e[33m 2.. \e[0m"
    sleep 1
    echo -e "\e[33m 1.. \e[0m"
    sleep 1

ask_install() { 
    install_cmd=$2

    if [[ "$AUTO_YES" = true ]]; then # Auto-installs packages without prompting b/c -y flag used
        echo -e "\e[32m Installing $pkg_name..."
        eval "$install_cmd"
    else
        read -p "\e[33m Install $pkg_name? (Y/n) " choice # Prompts to install each package individually because -y flag not used
        pkg_name=$1
        choice=${choice:-Y}
        if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
            echo -e "\e[32m Installing $pkg_name..."
            eval "$install_cmd"
        else
            echo "Skipping $pkg_name."
        fi
    fi
}

# Apt packages
ask_install "sudo" "apt install sudo -y"
ask_install "curl" "apt install curl -y"
ask_install "ffmpeg" "apt install ffmpeg -y"
ask_install "nmap" "apt install nmap -y"
ask_install "git" "apt install git -y"
ask_install "ufw" "apt install ufw -y"
ask_install "wget" "apt install wget -y"
ask_install "vim" "apt install vim -y"
ask_install "nfs client" "apt install nfs-common -y"
ask_install "samba" "apt install samba -y"
ask_install "docker" "apt install docker -y && systemctl start docker && systemctl enable docker"
ask_install "net-tools" "apt install net-tools -y"
ask_install "htop" "apt install htop -y"
ask_install "tree" "apt install tree -y"
ask_install "iotop" "apt install iotop -y"
ask_install "lsof" "apt install lsof -y"
ask_install "rsync" "apt install rsync -y"

echo -e "\e[32m All selected packages have been installed successfully.\e[0m"
echo -e "\e[34m Thank you for using linuxinstallhelper! @benny01000010 on Github\e[0m"

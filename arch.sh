#!/usr/bin/env bash

# Please run this script as root, or use "sudo" if you've already installed it. 
# If you have already installed sudo on your system, make sure to run sudo bash ./arch.sh in order to prevent errors.

# To auto install all packages at once, append "-y" or "--yes" to the end of your command to execute this script. More details can be found in the README.md file.

# A full list of packages that will be installed by this script can be found in the README.md file.


echo -e "\e[34m Welcome to linuxinstallhelper script... \e[0m"

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

sleep 2

detect_distro() { # Checks to see what distro is being used
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
        DISTRO_LIKE=$ID_LIKE
    elif [ -f /etc/arch-release ]; then
        DISTRO="arch"
    else
        DISTRO="unknown"
    fi
}

check_arch() { # Ensures that the script is only run on Arch Linux to prevent errors
    detect_distro
    
    # Check if it's Arch or an Arch-based distro
    if [[ "$DISTRO" == "arch" ]] || [[ "$DISTRO_LIKE" == *"arch"* ]]; then
        return 0
    else
        echo -e "\e[91m   ERROR: This script is for Arch Linux only!\e[0m"
        echo -e "\e[91m   Detected distribution: $DISTRO\e[0m"
        echo -e "\e[91m   Please use the appropriate script for your distribution.\e[0m"
        exit 1
    fi
}

check_arch

if [[ $EUID -ne 0 ]]; then # Checks to see if script is run as root or with sudo
   echo -e "\e[91m This script must be run as root or with sudo. Exiting... \e[0m" 
   exit 1
fi

echo -e "\e[33m Updating and upgrading existing packages...\e[0m" # Self-explanatory
pacman -Syu --noconfirm

AUTO_YES=false  # Determine if auto-install flag is used
for arg in "$@"; do
    if [[ "$arg" == "--yes" || "$arg" == "-y" ]]; then
        AUTO_YES=true
        break
    fi
done

if [[ "$AUTO_YES" = true ]]; then 
    echo -e "\e[32m Auto-installing all packages... \e[0m"
    sleep 2
else
    echo -e "\e[33m To install all packages AT ONCE, Ctrl+C then re-execute this script with the --yes or -y flag. \e[0m"
    echo -e "\e[33m Otherwise, you will be prompted for each package installation. Proceed with caution! \e[0m"
    echo -e "\e[33m Continuing with PROMPTED package installer in 5.. \e[0m"
    sleep 2
    echo -e "\e[33m 4.. \e[0m"
    sleep 1
    echo -e "\e[33m 3.. \e[0m"
    sleep 1
    echo -e "\e[33m 2.. \e[0m"
    sleep 1
    echo -e "\e[33m 1.. \e[0m"
    sleep 1
fi

ask_install() { 
    pkg_name=$1
    install_cmd=$2

    if [[ "$AUTO_YES" = true ]]; then # Auto-installs packages without prompting b/c -y flag used
        echo -e "\e[32m Installing $pkg_name...\e[0m"
        eval "$install_cmd"
    else
        echo -n -e "\e[33mInstall $pkg_name? (Y/n) \e[0m"
        read choice
        choice=${choice:-Y}
        if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
            echo -e "\e[32m Installing $pkg_name...\e[0m"
            eval "$install_cmd"
        else
            echo "Skipping $pkg_name."
        fi
    fi
}

# Apt packages
ask_install "sudo" "pacman -S sudo --noconfirm"
ask_install "curl" "pacman -S curl --noconfirm"
ask_install "ffmpeg" "pacman -S ffmpeg --noconfirm"
ask_install "nmap" "pacman -S nmap --noconfirm"
ask_install "git" "pacman -S git --noconfirm"
ask_install "ufw" "pacman -S ufw --noconfirm"
ask_install "wget" "pacman -S wget --noconfirm"
ask_install "vim" "pacman -S vim --noconfirm"
ask_install "nfs client" "pacman -S nfs-utils --noconfirm"
ask_install "samba" "pacman -S samba --noconfirm"
ask_install "net-tools" "pacman -S net-tools --noconfirm"
ask_install "htop" "pacman -S htop --noconfirm"
ask_install "tree" "pacman -S tree --noconfirm"
ask_install "iotop" "pacman -S iotop --noconfirm"
ask_install "lsof" "pacman -S lsof --noconfirm"
ask_install "rsync" "pacman -S rsync --noconfirm"

echo -e "\e[32m All selected packages have been installed successfully.\e[0m"
echo -e "\e[34m Thank you for using linuxinstallhelper! @benny01000010 on Github\e[0m"

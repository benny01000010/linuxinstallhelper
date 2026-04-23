#!/usr/bin/env bash

# Please run this script as root, or use "sudo" if you've already installed it. 
# If you have already installed sudo on your system, make sure to run sudo bash ./redhat.sh in order to prevent errors.

#To auto install all packages at once, append "-y" or "--yes" to the end of your command to execute this script. More details can be found in the README.md file.

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

check_redhat() { # Ensures that the script is only run on Red Hat Linux to prevent errors
    detect_distro
    
    # Check if it's Red Hat or a Red Hat-based distro
    if [[ "$DISTRO" == "rhel" ]] || [[ "$DISTRO_LIKE" == *"rhel"* ]]; then
        return 0
    else
        echo -e "\e[91m   ERROR: This script is for Red Hat Linux only!\e[0m"
        echo -e "\e[91m   Detected distribution: $DISTRO\e[0m"
        echo -e "\e[91m   Please use the appropriate script for your distribution.\e[0m"
        exit 1
    fi
}

check_redhat

if [[ $EUID -ne 0 ]]; then # Checks to see if script is run as root or with sudo
   echo -e "\e[91m This script must be run as root or with sudo. Exiting... \e[0m" 
   exit 1
fi

echo -e "\e[33m Updating and upgrading existing packages...\e[0m" # Self-explanatory
dnf upgrade -y
echo -e "\e[33m Autoremoving packages that are no longer needed... \e[0m"
dnf autoremove -y
echo -e "\e[32m Existing packages updated and unnecessary packages removed successfully.\e[0m"

AUTO_YES=false # Checks to see if auto-install -y flag is used
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

    if [[ "$SHOW_LOGS" = true ]]; then
        install_cmd="$install_cmd > /dev/null 2>&1"
    fi 

    if [[ "$AUTO_YES" = true ]]; then
        echo "Installing $pkg_name..." # auto installs all packages since -y flag used
        eval "$install_cmd"
    else
        read -p "Install $pkg_name? (Y/n) " choice # prompts to install or decline for each individual package since -y flag not used
        choice=${choice:-Y}
        if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
            echo "Installing $pkg_name..."
            eval "$install_cmd"
        else
            echo "Skipping $pkg_name."
        fi
    fi
}

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
ask_install "cli-blackjack? It is a command-line blackjack game written by the developer of this installer tool. Accepting the installation will clone the repository from Github, and you can play the game by entering the directory and executing the blackjack.sh script." "git clone https://github.com/benny01000010/cli-blackjack"

echo -e "\e[32m All selected packages have been installed successfully.\e[0m"
echo -e "\e[34m Thank you for using linuxinstallhelper! Please consider "starring" this repository on Github\e[0m"
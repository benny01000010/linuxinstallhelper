# linuxinstallhelper
This script package installs helpful tools on a fresh Linux install. Supported (currently) on Debian based distros, Arch, and Red Hat.

# Using this Script
1. Clone this repository (if you have already installed Git) by running the command git clone https://github.com/benny01000010/linuxinstallhelper
        If you have not already installed Git on your machine, clone the repo on another computer and transfer the files over with a USB or otherwise.
2. Make the filename that matches your distro executable (if it isn't already). For example, if you are running Debian, make debian.sh executable on your new installation.
3. Execute the file as root or using sudo.
4. Follow the prompts to complete your installation.

**NOTE** that to install all the packages at once append -y to your command when executing the .sh file.
If you do not append -y to your command, you will be prompted before each package installs to either accept or decline the installation. 
If you forget the -y flag, don't worry, just Ctrl+C and re-run the command. The installer will remind you of this as well.
The installer will also check your distrobution to make sure you have executed the correct file.

**Full Packages List**
Debian/Ubuntu:
  - sudo
  - curl
  - ffmpeg
  - nmap
  - git
  - ufw
  - wget
  - vim
  - nfs
  - samba
  - docker (the script will also start and enable docker as a system service)
  - net-tools
  - htop
  - tree
  - iotop
  - lsof
  - rsync

Red Hat:
  - EPEL
  - sudo
  - curl
  - nmap
  - git
  - firewalld
  - wget
  - vim
  - nfs-utils
  - samba
  - podman
  - rsync
  - net-tools
  - openssh-server
  - htop
  - tree
  - iotop
  - lsof

Arch:
  - sudo
  - curl
  - nmap
  - git
  - firewalld
  - wget
  - vim
  - nfs-utils
  - samba
  - podman
  - rsync
  - net-tools
  - openssh-server
  - htop
  - tree
  - iotop
  - lsof

# Development
  - Combining all 3 scripts (debian, arch, redhat) into one with a feature that auto-detects your distro and executes the right commands.
  - Bugfixes & minor improvements.

Open an issue or submit a pull request if there are packages you feel should be added or if there is a bug that needs fixed. This repository is actively maintained and is still under development!
Courtesy of @benny01000010 on Github. Please feel free to contribute! 

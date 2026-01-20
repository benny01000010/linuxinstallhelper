# linuxinstallhelper
This script package installs helpful tools on a fresh Linux install.

"installscript.sh" first runs apt update && apt upgrade -y, then prompts you to install the following packages:
Sudo, curl, ffmpeg, wget, ufw, vim, Git (if not already installed), docker, and nmap.

# Using this Script
1. Clone this repository (if you have already installed Git) by running the command git clone https://github.com/benny01000010/linuxinstallhelper
        If you have not already installed Git on your machine, clone the repo on another computer and transfer the files over with a USB or otherwise.
2. Make the filename that matches your distro executable. For example, if you are running Debian, make debian.sh executable on your new installation.
3. Execute the file as root or using sudo.
4. Follow the prompts to complete your installation.


**NOTE** that to install all the packages at once append -y to your command when executing the .sh file.
If you do not append -y to your command, you will be prompted before each package installs to either accept or decline the installation. 
If you forget the -y flag, don't worry, just Ctrl+C and re-run the command. The installer will remind you of this as well.

Open an issue or submit a pull request if there are packages you feel should be added.
Courtesy of @benny01000010 on Github. Please feel free to contribute! 

**Currently In Development**
- A version compatible with Red Hat
- A version compatible with Arch
- An addition to the script that can reboot your system if a kernel update is detected when running apt update && apt upgrade

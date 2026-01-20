# linuxinstallhelper
This script package installs helpful tools on a fresh Linux install.

"installscript.sh" first runs apt update && apt upgrade -y, then prompts you to install the following packages:
Sudo, curl, ffmpeg, wget, ufw, vim, Git (if not already installed), docker, and nmap.

**How To Use this Script**
1. Run this command on your fresh Linux install to clone the repository: git clone https://github.com/benny01000010/linuxinstallhelper
2. cd into the linuxinstallhelper directory and run this command: chmod +x debian.sh or redhat.sh (in development) or arch.sh (also in development). Please pick the correct file to chmod based off of your Linux distrobution.
3. Execute the file you just ran "chmod" on as root or using sudo.

**NOTE** that to install all the packages at once append -y to either of the commands in Step 3.
If you do not append -y to your command, you will be prompted before each package installs to either accept or decline the installation.

Open an issue or submit a pull request if there are packages you feel should be added.
Courtesy of @benny01000010 on Github. Please feel free to contribute! 

**Currently In Development**
- A version compatible with Red Hat
- A version compatible with Arch
- An addition to the script that can reboot your system if a kernel update is detected when running apt update && apt upgrade

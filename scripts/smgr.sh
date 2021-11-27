#!/data/data/com.termux/files/usr/bin/bash

if [ "$(id -u)" = "0" ]; then
	echo "sarchile should not be used as root!"
	exit 1
fi

## Initialize global variables

# Installation directory
DIR=""

# Define system architecture variables

ARCH=$(uname -m)
IMAGE_AARCH64="https://git.io/JM3Zk"
IMAGE_ARM="https://git.io/JM3Zv"
IMAGE_AMD64=""


case "$1" in
	install)
		if [[ -d "~/.sarchile32" || -d "~/.sarchile" ]]
		then
			echo "You already have sarchile installed on your system"
			# Yes, multiple sarchile installation is planned for 1.0 release
			exit 0
		else
			case $ARCH in
				armv7l | armv8l)
					echo "Setting up sarchile 32bit (aarch32)"
					IMAGE_URL=$IMAGE_ARM
					DIR="~./sarchile32"
				;;
				aarch64)
					if [[ "$2" == "--force32" ]]
					then
						echo "Your system is capable to run 64bit version of sarchile,"
						echo "we highly suggest you to install aarch64 variant instead, which is deafult to your device."
						echo ""
						echo "aarch64 has many more packages as well as better supported by communities"
						echo "such as Arch Linux Forum."
						read -p "Are you sure you want to install 32bit version of sarchile? (y/n)" yn
    						case $yn in
        					[Yy]* )
								echo "Solid copy, installing 32bit version of sarchile (armv7*/armv8l)"
								IMAGE_URL=$IMAGE_ARM
								DIR="~./sarchile32"
							;;
        					[Nn]* )
								echo "OK, reverting back to sarchile aarch64 installation"
								IMAGE_URL=$IMAGE_ARRCH64
								DIR="~./sarchile"
							;;
        					* ) echo "Please answer by typing y (for yes) or n (for no).";;
    						esac
					else
						echo "Setting up sarchile for aarch64 (aarch64)"
						IMAGE_URL=$IMAGE_ARCH64
						DIR="~./sarchile"
					fi
				;;
				x86)
					echo "Sorry, sarchile do not support i686 (32bit x86)"
					exit 1
				;;
				x86_64)
					if [[ "$2" == "--force32" ]]
					then
						echo "Sorry, sarchile do not support i686 (32bit x86)"
						exit 1
					else
						echo "sarchile for amd64 support is under development."
						echo "Stay tuned!"
					exit 0
					fi
				;;
			esac
		echo ""

		# Create a directory for sarchile
		echo "sarchile rootfs will be installed under directory $DIR"
		mkdir $DIR
		cd $DIR
		echo ""

		# Get base image for installation
		echo "Getting sarchile base image, please do not kill the installation unless error messages are spawned."
		echo "Please wait, this may take a while..."
		/data/data/com.termux/files/usr/bin/aria2c $IMAGE_URL -o sarchile.tar.gz -x 16 -q

		# Extract base image
		echo "Extracting base image..."
		proot --link2symlink -0 bsdtar -xpf sarchile.tar.gz 2> /dev/null || :

		# Finalizing installation
		# Remove image tarball
		echo "Finalizing installation..."
		rm sarchile.tar.gz

		# Replace resolv.conf file
		mv $DIR/etc/resolvconf.conf $DIR/etc/resolv.conf

		# Print successful installation message 
		echo "Installation completed! Fire it up with smgr start. Note that you're logged in as root user by default."
		echo ""
		echo "sarchile comes with NO warranty."
		echo "If you face with any bug along the way, please make an issue on sarchile's GitHub repository"
		echo "To get help, please see Discussion on the repository as well."
		echo "Enjoy!"
		
		exit 0
		;;
	uninstall)
		chmod -R 777 ~/.sarchile
		rm -rf ~/.sarchile
		echo "Successfully uninstalled sarchile!"
		exit 0
	    ;;
	start)
	unset LD_PRELOAD
	echo 
		if [[ -d "~/.sarchile32" ]]
		then
			linux32 proot --link2symlink -0 -r ~/.sarchile32 -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w /root /bin/env -i HOME=/root TERM="$TERM" LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/bash --login
		elif [[ -d "~/.sarchile" ]]
		then
			proot --link2symlink -0 -r ~/.sarchile -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w /root /bin/env -i HOME=/root TERM="$TERM" LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/bash --login
		else
			echo "error: sarchile is not installed, cannot start."
			echo 'Maybe "smgr install" instead?'
			exit 2
		fi
		;;
	*)
	    echo "Usage: smgr {install|uninstall|start} {--force32}"
	    exit 2
	    ;;
esac



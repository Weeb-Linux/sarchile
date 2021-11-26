#!/data/data/com.termux/files/usr/bin/bash

DIR=~/.sarchile

ARCH=$(uname -m)
IMAGE_ARM64=
IMAGE_ARM=
IMAGE_x86_64=

case "$1" in
	install)
		case $ARCH in
			armv7l | armv8l)
				echo "Setting up sarchile for armv7l & armv8l (arm)"
				IMAGE_URL=$IMAGE_ARM
			;;
			aarch64)
				if [[ "$2" == "--force32" ]]
				then
				echo "You forced 32bit image, setting up sarchile for arm, you'll be using proot with linux32"
				IMAGE_URL=$IMAGE_ARM
				else
				echo "Setting up sarchile for aarch64 (arm64)"
				IMAGE_URL=$IMAGE_ARM64
				fi
			;;
			x86)
				echo "sorry we don't support x86"
				exit 0
			;;
			x86_64)
				if [[ "$2" == "--force32" ]]
				then
				echo "sorry we don't support x86, --force32 won't work"
				else
				echo "Coming soon"
				exit 0
				fi
			;;
		esac
		echo ""

		# Create a directory for sarchile
		echo "sarchile rootfs will be installed under directory .sarchile"
		mkdir $DIR
		cd $DIR
		echo ""

		# Get base image for installation
		echo "Getting sarchile base image, please do not kill the installation unless error messages are spawned."
		echo "Please wait, this may take a while..."
		/data/data/com.termux/files/usr/bin/aria2c $IMAGE_URL -o sarchile.tar.gz -x 16 -q

		# Extract base image
		echo "Extracting base image..."
		/data/data/com.termux/files/usr/bin/tar xf sarchile.tar.gz > /dev/null 2>&1 

		# Finalizing installation

		# Remove image tarball
		echo "Reclaiming disk space..."
		rm sarchile.tar.gz

		# Fix directories permission
		chmod -R 755 $DIR/etc
		chmod -R 755 $DIR/usr
		chmod -R 755 $DIR/var
		chmod -R 755 $DIR/opt
		chmod -R 755 $DIR/mnt
		chmod -R 750 $DIR/root
		chmod -R 755 $DIR/run

		# Replace resolv.conf file
		mv $DIR/etc/resolvconf.conf $DIR/etc/resolv.conf

		# Print successful installation message 
		echo "Installation completed! Fire it up with smgr start."
		echo ""
		echo "Enjoy!"
		;;
	uninstall)
		chmod -R 777 ~/.sarchile
	    rm -rf ~/.sarchile
	    echo "Successfully uninstalled sarchile!"
	    exit 0
	    ;;
	start)
		if [ -d $DIR ]
		then
			if [[ "$2" == "--force32" ]]
			unset LD_PRELOAD && linux32 proot --link2symlink -0 -r ~/.sarchile -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/bash --login
			else
			unset LD_PRELOAD && proot --link2symlink -0 -r ~/.sarchile -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/bash --login
			fi
		else
			echo "error: sarchile is not installed, cannot start."
			echo "Maybe smgr install instead?"
			exit 2
		fi
		;;
	*)
	    echo "Usage: smgr {install|uninstall|start} {--force32}"
	    exit 2
	    ;;
esac



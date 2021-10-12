#!/data/data/com.termux/files/usr/bin/bash

# Input validator and printing basic help

case "$1" in
	install)
		IMAGE=https://github.com/Weeb-Linux/sarchile/releases/download/base/base.tar.gz
		DIR=~/.sarchile
		;;
	uninstall)
		chmod -R 777 ~/.sarchile
	    rm -rf ~/.sarchile
	    echo "Successfully uninstalled sarchile!"
	    exit 0
	    ;;
	start)
		if [ -d ".sarchile" ]
			then
				unset LD_PRELOAD && proot --link2symlink -0 -r ~/.sarchile -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/bash --login
			else
				echo "error: sarchile is not installed, cannot start."
				echo "Maybe smgr install instead?"
				exit 2
		fi
		;;
	*)
	    echo $"Usage: $0 {install|uninstall|start}"
	    exit 2
	    ;;
esac

# Create a directory for sarchile
echo $"sarchile will be installed in $DIR"
mkdir $DIR
cd $DIR

# Get base image for installation
echo "Getting sarchile base image. Please wait..."
echo ""
/data/data/com.termux/files/usr/bin/aria2c $IMAGE -o sarchile.tar.gz -x 16
echo ""

# Extract base image
echo "Extracting base image..."
/data/data/com.termux/files/usr/bin/tar xf ~/sarchile.tar.gz

# Finish the installation
chmod +w .
echo "Reclaiming disk space..."
rm sarchile.tar.gz

# Finalizing

echo "Installation completed!"
echo "We highly suggest you to immediately update the sarchile even with latest Arch repository"
echo "Enjoy!"


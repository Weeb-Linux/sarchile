echo "Welcome to sarchile!"
echo "brought to you by Weeb/Linux Team."
echo "licensed under MIT License, free!"
echo ""

echo "=============="

echo ""
echo "Installing required packages from Termux..."
echo ""

pkg update -y
pkg install wget proot tar aria2 -y

echo ""
echo "Installing sarchile manager tool..."
echo ""

wget -O /data/data/com.termux/files/usr/bin/smgr https://git.io/JKJrk > /dev/null 2>&1 
chmod +x /data/data/com.termux/files/usr/bin/smgr

echo ""
echo "Environment initialization is done!"
echo "To begin with sarchile installation, do smgr install."
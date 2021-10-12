echo "Welcome to sarchile!"
echo "brought to you by Weeb/Linux Team."
echo "licensed under MIT License, free!"

echo "======"

echo "Installing necessary packages from Termux..."
echo ""

pkg install proot tar aria2 -y

echo "Installing sarchile manager tool..."

curl -o /data/data/com.termux/files/usr/bin/smgr https://git.io/JKJrk
chmod +x /data/data/com.termux/files/usr/bin/smgr

echo "Environment initialzation is done!"
echo "To begin with sarchile installation, do smgr install."
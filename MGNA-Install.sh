#!/bin/bash -e

# Copyleft (c) 2022.
# -------==========-------
# Ubuntu Server 22.04.01 || Armbian 22.11 Jammy
# Hostname: MGNA5-1
# Username: fumpict
# Password: 1478963
# -------==========-------
# To Run This Script
# wget https://raw.githubusercontent.com/Hamid-Najafi/Medical-Gas-Notification-Alarm/main/MGNA-Install.sh && chmod +x MGNA-Install.sh && sudo ./MGNA-Install.sh
# -------==========-------
echo "-------------------------------------"
echo "Configuring User & Groups"
echo "-------------------------------------"
adduser fumpict --gecos "FUMP ICT,RoomNumber,WorkPhone,HomePhone" --disabled-password
echo "fumpict:1478963" | chpasswd
usermod -a -G sudo fumpict
usermod -a -G dialout fumpict
usermod -a -G audio fumpict
usermod -a -G video fumpict
usermod -a -G input fumpict
echo "fumpict user added to sudo, dialout, audio, video & input groups"
# Give fumpict Reboot Permision
chown root:fumpict /bin/systemctl
sudo chmod 4755 /bin/systemctl
echo "-------------------------------------"
echo "Setting Hostname"
echo "-------------------------------------"
echo "Set New Hostname: (MGNA-Floor-Room)"
read hostname
hostnamectl set-hostname $hostname
string="$hostname"
file="/etc/hosts"
if ! grep -q "$string" "$file"; then
  printf "\n%s" "127.0.0.1 $hostname" >> "$file"
fi
echo "-------------------------------------"
echo "Setting TimeZone"
echo "-------------------------------------"
timedatectl set-timezone Asia/Tehran 
echo "-------------------------------------"
echo "Installing Pre-Requirements"
echo "-------------------------------------"
export DEBIAN_FRONTEND=noninteractive
apt update && apt upgrade -y
apt install -y software-properties-common git avahi-daemon python3-pip 
apt install -y debhelper build-essential gcc g++ gdb cmake 
echo "-------------------------------------"
echo "Installing Qt & Tools"
echo "-------------------------------------"
apt install -y mesa-common-dev libfontconfig1 libxcb-xinerama0 libglu1-mesa-dev
apt install -q -y qt5* qttools5* qtmultimedia5* qtwebengine5* qtvirtualkeyboard* qtdeclarative5* qt3d5*
apt install -q -y qtbase5* 
apt install -q -y libqt5*
apt install -q -y qml-module*
echo "-------------------------------------"
echo "Installing MGNA Application"
echo "-------------------------------------"
url="https://github.com/Hamid-Najafi/Medical-Gas-Notification-Alarm.git"

folder="/home/fumpict/C1"
[ -d "${folder}" ] && rm -rf "${folder}"

folder="/home/fumpict/Medical-Gas-Notification-Alarm"
[ -d "${folder}" ] && rm -rf "${folder}"

git clone "${url}" "${folder}"

cd /home/fumpict/Medical-Gas-Notification-Alarm/MGNA
touch -r *.*
qmake
make -j2

chown -R fumpict:fumpict /home/fumpict/Medical-Gas-Notification-Alarm
echo "-------------------------------------"
echo "Creating Service for MGNA Application"
echo "-------------------------------------"
journalctl --vacuum-time=60d
loginctl enable-linger fumpict

cat > /etc/systemd/system/mgna.service << "EOF"
[Unit]
Description=FUMP-ICT Medical Gas Notification Alarm v1.0

[Service]
Type=idle
Environment="XDG_RUNTIME_DIR=/run/user/1000"
Environment="DBUS_SESSION_BUS_ADDRESS=unix:path=$XDG_RUNTIME_DIR/bus"
Environment="QT_QPA_PLATFORM=eglfs"
Environment="QT_QPA_EGLFS_ALWAYS_SET_MODE=1"
# Environment="QT_QPA_EGLFS_HIDECURSOR=1"
ExecStart=/home/fumpict/Medical-Gas-Notification-Alarm/MGNA/MGNA -platform eglfs
Restart=always
User=c1tech

[Install]
WantedBy=default.target
EOF

systemctl daemon-reload
systemctl enable mgna
systemctl restart mgna
echo "-------------------------------------"
echo "Configuring Splash Screen"
echo "-------------------------------------"
apt -y autoremove --purge plymouth
apt -y install plymouth plymouth-themes
# plymouth-set-default-theme --list
sudo plymouth-set-default-theme spinner

# By default ubuntu-text is active 
# /usr/share/plymouth/themes/ubuntu-text/ubuntu-text.plymouth
# We Will use bgrt (which is same as spinner but manufacture logo is enabled) theme with our custom logo
cp /usr/share/plymouth/themes/spinner/bgrt-fallback.png{,.bak}
cp /usr/share/plymouth/themes/spinner/watermark.png{,.bak}
cp /usr/share/plymouth/ubuntu-logo.png{,.bak}

# This Comes abow Spinner
cp /home/c1tech/C1-PassBox/bgrt-c1.png /usr/share/plymouth/ubuntu-logo.png
# This Comes bellow Spinner
cp /home/c1tech/C1-PassBox/bgrt-c1.png /usr/share/plymouth/themes/spinner/watermark.png

update-initramfs -u
# update-alternatives --list default.plymouth
# update-alternatives --display default.plymouth
# update-alternatives --config default.plymouth
echo "-------------------------------------"
echo "Done, Performing System Reboot"
echo "-------------------------------------"
init 6
echo "-------------------------------------"
echo "Test Mic and Spk"
echo "-------------------------------------"
sudo apt install -y lame sox libsox-fmt-mp3

arecord -v -f cd -t raw | lame -r - output.mp3
play output.mp3
# -------==========-------
wget https://raw.githubusercontent.com/alphacep/vosk-api/master/python/example/test_microphone.py
python3 test_microphone.py -m fa
# -------==========-------
sudo apt-get --purge autoremove pulseaudio
# -------==========-------
sudo rm /etc/systemd/system/mgna.service
sudo systemctl daemon-reload
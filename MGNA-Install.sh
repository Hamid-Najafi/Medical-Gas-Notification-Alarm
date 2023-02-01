#!/bin/bash -e

# Copyleft (c) 2022.
# -------==========-------
# Ubuntu Server 22.04.01
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
apt install -y qtbase5-dev qt5-qmake libqt5quickcontrols2-5 libqt5virtualkeyboard5* qtdeclarative5-dev qtmultimedia5* libqt5serial*  libqt5multimedia* libqt5svg5-dev libqt5qml5 libqt5quick5  qttools5*
apt install -y qml-module-qtquick* qml-module-qt-labs-settings qml-module-qtgraphicaleffects 
echo "-------------------------------------"
echo "Installing Contold Panel Application"
echo "-------------------------------------"
url="https://github.com/Hamid-Najafi/Medical-Gas-Notification-Alarm.git"
folder="/home/fumpict/Medical-Gas-Notification-Alarm"
[ -d "${folder}" ] && rm -rf "${folder}"
git clone "${url}" "${folder}"
folder="/home/fumpict/C1"
[ -d "${folder}" ] && rm -rf "${folder}"
cd /home/fumpict/Medical-Gas-Notification-Alarm/MGNA
touch -r *.*
qmake
make -j4 

chown -R fumpict:fumpict /home/fumpict/Medical-Gas-Notification-Alarm
ln -s /home/fumpict/Medical-Gas-Notification-Alarm/MGNA/passBox /home/fumpict/Medical-Gas-Notification-Alarm/MGNA/mgna
echo "-------------------------------------"
echo "Creating Service for Contold Panel Application"
echo "-------------------------------------"
journalctl --vacuum-time=60d
loginctl enable-linger fumpict

cat > /etc/systemd/system/mgna.service << "EOF"
[Unit]
Description=FUMP-ICT Medical Gas Notification Alarm v1.0

[Service]
Type=idle
Environment="QT_QPA_EGLFS_HIDECURSOR=1"
ExecStart=/home/fumpict/Medical-Gas-Notification-Alarm/MGNA/mgna -platform eglfs
Restart=always
User=root
[Install]
WantedBy=default.target
EOF

systemctl daemon-reload
systemctl enable mgna

echo "-------------------------------------"
echo "Configuring Splash Screen"
echo "-------------------------------------"
File=/boot/cmdline.txt
String=\ quiet\ splash\ plymouth.ignore-serial-consoles
if grep -q "$String" "$File"; then
echo "Boot CMDLINE OK"
else
truncate -s-1 "$File"
echo -n "$String" >> /boot/cmdline.txt
fi

sudo nano /boot/config.txt
disable_splash=1

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
# cp /home/fumpict/Medical-Gas-Notification-Alarm/bgrt-c1.png /usr/share/plymouth/themes/spinner/bgrt-fallback.png
cp /home/fumpict/Medical-Gas-Notification-Alarm/watermark-ict.png /usr/share/plymouth/themes/spinner/watermark.png
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
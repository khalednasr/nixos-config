#!/bin/bash
WORKING_DIR="/tmp/vivado"
INSTALLER_NAME=$(basename ${INSTALLER_TAR} .tar)
INSTALLER_DIR="$WORKING_DIR/$INSTALLER_NAME"

echo $INSTALLER_TAR
echo $INSTALLER_NAME
echo $WORKING_DIR

rm -rf $WORKING_DIR
mkdir -p $WORKING_DIR
tar -xvf $INSTALLER_TAR -C $WORKING_DIR

cd $INSTALLER_DIR
./xsetup --agree XilinxEULA,3rdPartyEULA \
  --batch Install \
  --config $SCRIPT_DIR/install_config.txt \
  --location $INSTALL_DIR

cd $HOME
rm -rf $WORKING_DIR

sudo apt-get update
sudo apt-get install -y libc6-dev-i386 net-tools
sudo apt-get install -y graphviz
sudo apt-get install -y make
sudo apt-get install -y unzip
sudo apt-get install -y zip
sudo apt-get install -y g++
sudo apt-get install -y libtinfo5
sudo apt-get install -y xvfb
sudo apt-get install -y git
sudo apt-get install -y libncurses5-dev
sudo apt-get install -y libc6-dev-i386
sudo apt-get install -y libnss3-dev
sudo apt-get install -y libgdk-pixbuf2.0-dev
sudo apt-get install -y libgtk-3-dev
sudo apt-get install -y libxss-dev 
sudo apt-get install -y libasound2t64
sudo apt-get install -y openssl
sudo apt-get install -y fdisk 
sudo apt-get install -y  libsecret-1-dev

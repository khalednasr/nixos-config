#!/bin/sh
CONTAINER_NAME=xilinx
DISTRO_IMAGE=ubuntu:24.04
INSTALLER_TAR=$1
INSTALL_DIR=$2
SCRIPT_DIR=$(dirname "$0")

distrobox rm $CONTAINER_NAME --force
distrobox create -n $CONTAINER_NAME -i $DISTRO_IMAGE --additional-flags "--env _JAVA_AWT_WM_NONREPARENTING=1"

distrobox enter $CONTAINER_NAME \
  --additional-flags \
  "--env INSTALLER_TAR=$INSTALLER_TAR --env INSTALL_DIR=$INSTALL_DIR --env SCRIPT_DIR=$SCRIPT_DIR" \
  -- bash $SCRIPT_DIR/container_install.sh


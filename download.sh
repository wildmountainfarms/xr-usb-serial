#!/usr/bin/env sh
set -e  # any non-zero exit code results in the program exiting
set -u  # undefined variables are errors
set -o pipefail  # If any command in a pipeline fails, that return code will be used as the return code for the whole thing
cd "$(dirname "$0")"

# https://www.maxlinear.com/support/design-tools/software-drivers

# xr_usb_serial_common_lnx-3.6-and-newer-pak.zip

mkdir -p downloads/

path_1a='downloads/xr_usb_serial_common_lnx-2.6.18-to-3.4-pak-1A.zip'
path_1g='downloads/xr_usb_serial_common_lnx-3.6-and-newer-pak-1G.zip'
# NOTE: I'm not sure if these download links result in the same download if updates are made to the drivers
download_1a='https://www.maxlinear.com/content/document.ashx?id=21652'
download_1g='https://www.maxlinear.com/content/document.ashx?id=21651'


wget -O "$path_1a" "$download_1a"
wget -O "$path_1g" "$download_1g"

rm -rf versions/

mkdir -p versions/1A
mkdir -p versions/1G

unzip "$path_1a" -d versions/1A
unzip -j "$path_1g" 'Linux_3.6/*' -d versions/1G

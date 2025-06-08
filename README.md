# xr-usb-serial

This repository contains drivers downloaded from https://www.maxlinear.com/support/design-tools/software-drivers
along with patches to those drivers.
Because those drivers are not stored in git, understanding the diffs between them can be difficult.
For that reason, this repository contains different versions of the same driver in an attempt to capture exactly the contents of each version byte for byte.

This repository likely will not be kept up to date, but I hope to capture as much knowledge as I can here about XR drivers.

## Kernel versions this is designed for

This should work with 3.6 <= Linux <= 6.12, although you probably don't need these drivers for Linux >= 6.6,
as the `xr_serial` module should work for RS485 communication.

I put this repository together because I wanted to try the Exar/MxL USB Serial Driver on a modern Linux kernel.
If you would like, you can blacklist `xr_serial` like so:

```shell
echo 'blacklist xr_serial' | sudo tee /etc/modprobe.d/blacklist-xr_serial.conf
```


## Install instructions

I like to install using `dkms`. I use a version of `1xyz` here to not conflict with any official versions.

```shell
sudo rm -rf /usr/src/xr_usb_serial_common-1xyz
sudo cp -r xr_usb_serial /usr/src/xr_usb_serial_common-1xyz
sudo cp dkms.conf /usr/src/xr_usb_serial_common-1xyz/


sudo apt-get install linux-headers-$(uname -r)
# or for Raspberry Pi OS
sudo apt-get install raspberrypi-kernel-headers

# remove any previous versions if necessary
sudo dkms remove xr_usb_serial_common/1a
sudo dkms add -m xr_usb_serial_common -v 1xyz
sudo dkms build -m xr_usb_serial_common -v 1xyz
sudo dkms install -m xr_usb_serial_common -v 1xyz

echo blacklist cdc-acm | sudo tee /etc/modprobe.d/blacklist-cdc-acm.conf

sudo update-tirfs
# or
sudo update-initramfs -u
```

## Uninstall instructions

```shell
sudo dkms remove xr_usb_serial_common/1xyz
sudo rm -f /etc/modprobe.d/blacklist-xr_serial.conf
```

## Debugging

```shell
# check to see if xr_serial or xr_usb_serial_common has any active devices
lsmod | grep serial

# For xr_serial module
ls -l /dev/ttyUSB*
# For devices belonging to this driver's module
ls -l /dev/ttyXRUSB*
# or simply
ls -l /dev/tty*USB*

# For Linux >= 6.6
sudo modinfo xr_serial
# When this driver is installed
sudo modinfo xr_usb_serial_common

udevadm info --query=all --name=/dev/ttyUSB0
```

## Patch descriptions

* `<asm/unaligned.h>` is now `<linux/unaligned.h>` on v6.12.0 and newer
* `#undef CONFIG_GPIOLIB`
  * `gpiochip_add` is not defined anywhere I could find, but `gpiochip_add_data` has a similar name
    * https://www.kernel.org/doc/html/v6.12/driver-api/gpio/index.html#c.gpiochip_add_data

## Other repositories

There exist many repositories containing Exar/MxL USB Serial Driver source code, many with patches applied to them.

* https://github.com/kasbert/epsolar-tracer/tree/master/xr_usb_serial_common-1a
  * Version 1A with patches
* https://github.com/enlyze/xr-usb-serial
  * Version 1C with patches
* https://github.com/victor999/xr_usb_serial
* https://github.com/niosHD/xr_usb_serial_common-1c

Other drivers (unrelated to this):
* https://github.com/mchehab/xr_serial
* https://github.com/kasbert/epsolar-tracer/tree/master/linux_usb_serial
* https://raw.githubusercontent.com/torvalds/linux/v5.13-rc6/drivers/usb/serial/xr_serial.c


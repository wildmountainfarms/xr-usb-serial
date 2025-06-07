# xr-usb-serial

This repository contains drivers downloaded from https://www.maxlinear.com/support/design-tools/software-drivers
along with patches to those drivers.
Because those drivers are not stored in git, understanding the diffs between them can be difficult.
For that reason, this repository contains different versions of the same driver in an attempt to capture exactly the contents of each version byte for byte.

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


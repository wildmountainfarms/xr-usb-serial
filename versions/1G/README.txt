Exar/MxL USB Serial Driver
======================
Version 1G  2024/07/08
	Fix GPIO related compile error
	Fix tty driver related calls for changes up to Kernel 6.8
	
Version 1F  2022/05/18
	Fix tty driver related calls for changes from Kernel 5.15

Version 1E  2021/11/17
	Modify function definitions corresponding to changes in newer Kernel

Version 1D  2021/9/14
	Add GPIO operation support
	Use dynamic allocate memory for usb_control_msg
	Avoid re-configuring the flow mode if no changes
	Remove obsoleted flag check for newer version
	Fix XR21B142x incorrect register mapping
	Fix baud rate setting for Big-Endian system
	XR2280x wide mode setting
	Clean up ident
	
Version 1C  2017/1/11
	Add the 9-bit mode support.
	Disable the debug messages.

Version 1B, 11/6/2015
	Fixed Bug: The conditional logic to support kernel 3.9 was incorrect(line 396 in xr_usb_serial_common.c). 

Version 1A, 1/9/2015

This driver will work with any USB UART function in these Exar/MxL devices:
	XR21V1410/1412/1414
	XR21B1411
	XR21B1420/1422/1424
	XR22801/802/804

The source code has been tested on various Linux kernels from 3.6.x to 6.8.  
This may also work with newer kernels as well.  


Installation
------------

* Compile and install the common usb serial driver module

	# make
	# insmod ./xr_usb_serial_common.ko


* Plug the device into the USB host.  You should see up to four devices created,
  typically /dev/ttyXRUSB[0-3].


Tips for Debugging
------------------

* Check that the USB UART is detected by the system

	# lsusb

* Check that the CDC-ACM driver was not installed for the Exar USB UART

	# ls /dev/tty*

	To remove the CDC-ACM driver and install the driver:

	# rmmod cdc-acm
	# modprobe -r usbserial
	# modprobe usbserial
	# insmod ./xr_usb_serial_common.ko


Technical Support
-----------------
Send any technical questions/issues to uarttechsupport@exar.com. 


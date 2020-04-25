Drobo 5D on Linux
=================

Drobo USB3 Plug `udevadm monitor` logs:

```
monitor will print the received events for:
UDEV - the event which udev sends out after rule processing
KERNEL - the kernel uevent

KERNEL[2870450.042225] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3 (usb)
KERNEL[2870450.107328] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0 (usb)
KERNEL[2870450.107752] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0 (scsi)
KERNEL[2870450.107999] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/scsi_host/host0 (scsi_host)
UDEV  [2870450.118734] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3 (usb)
UDEV  [2870450.125445] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0 (usb)
UDEV  [2870450.128038] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0 (scsi)
UDEV  [2870450.130466] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/scsi_host/host0 (scsi_host)
KERNEL[2870451.101132] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0 (scsi)
KERNEL[2870451.101581] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:0 (scsi)
KERNEL[2870451.101635] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:0/scsi_disk/0:0:0:0 (scsi_disk)
KERNEL[2870451.101670] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:0/scsi_device/0:0:0:0 (scsi_device)
KERNEL[2870451.102136] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:0/bsg/0:0:0:0 (bsg)
UDEV  [2870451.104067] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0 (scsi)
KERNEL[2870451.105672] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:1 (scsi)
KERNEL[2870451.105755] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:1/scsi_disk/0:0:0:1 (scsi_disk)
KERNEL[2870451.105794] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:1/scsi_device/0:0:0:1 (scsi_device)
KERNEL[2870451.106641] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:1/bsg/0:0:0:1 (bsg)
KERNEL[2870451.109193] add      /devices/virtual/bdi/8:0 (bdi)
KERNEL[2870451.109271] add      /devices/virtual/bdi/8:16 (bdi)
UDEV  [2870451.116836] add      /devices/virtual/bdi/8:0 (bdi)
UDEV  [2870451.119676] add      /devices/virtual/bdi/8:16 (bdi)
KERNEL[2870451.136350] add      /module/sg (module)
KERNEL[2870451.136934] add      /class/scsi_generic (class)
UDEV  [2870451.137478] add      /module/sg (module)
KERNEL[2870451.137999] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:0/scsi_generic/sg0 (scsi_generic)
KERNEL[2870451.138639] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:1/scsi_generic/sg1 (scsi_generic)
UDEV  [2870451.139148] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:0 (scsi)
UDEV  [2870451.139223] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:1 (scsi)
UDEV  [2870451.139801] add      /class/scsi_generic (class)
UDEV  [2870451.142693] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:0/scsi_device/0:0:0:0 (scsi_device)
UDEV  [2870451.142785] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:0/scsi_disk/0:0:0:0 (scsi_disk)
UDEV  [2870451.145408] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:0/bsg/0:0:0:0 (bsg)
UDEV  [2870451.150257] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:1/scsi_disk/0:0:0:1 (scsi_disk)
UDEV  [2870451.153961] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:1/bsg/0:0:0:1 (bsg)
UDEV  [2870451.154372] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:1/scsi_device/0:0:0:1 (scsi_device)
UDEV  [2870451.158297] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:0/scsi_generic/sg0 (scsi_generic)
UDEV  [2870451.163912] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:1/scsi_generic/sg1 (scsi_generic)
KERNEL[2870452.286444] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:1/block/sdb (block)
KERNEL[2870452.286547] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:1/block/sdb/sdb1 (block)
KERNEL[2870452.286653] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:1/block/sdb/sdb2 (block)
UDEV  [2870452.676554] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:1/block/sdb (block)
UDEV  [2870453.198028] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:1/block/sdb/sdb1 (block)
UDEV  [2870453.224766] add      /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/host0/target0:0:0/0:0:0:1/block/sdb/sdb2 (block)
KERNEL[2870453.700189] add      /module/hfsplus (module)
UDEV  [2870453.700950] add      /module/hfsplus (module)
KERNEL[2870453.701464] add      /kernel/slab/hfsplus_icache (slab)
UDEV  [2870453.702043] add      /kernel/slab/hfsplus_icache (slab)
KERNEL[2870453.702426] add      /kernel/slab/:t-0003840 (slab)
UDEV  [2870453.703100] add      /kernel/slab/:t-0003840 (slab)
KERNEL[2870453.709688] add      /module/nls_utf8 (module)
UDEV  [2870453.710385] add      /module/nls_utf8 (module)
```



Drobo USB3 Plug `journalctl -xn -f` logs:

```
Jun 27 23:37:19 raspberrypi kernel: usb 1-1.3: new high-speed USB device number 17 using dwc_otg
Jun 27 23:37:19 raspberrypi kernel: usb 1-1.3: New USB device found, idVendor=19b9, idProduct=3444
Jun 27 23:37:19 raspberrypi kernel: usb 1-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
Jun 27 23:37:19 raspberrypi kernel: usb 1-1.3: Product: Drobo5D
Jun 27 23:37:19 raspberrypi kernel: usb 1-1.3: Manufacturer: Drobo
Jun 27 23:37:19 raspberrypi kernel: usb 1-1.3: SerialNumber: D0B152501700572
Jun 27 23:37:19 raspberrypi kernel: usb-storage 1-1.3:1.0: USB Mass Storage device detected
Jun 27 23:37:19 raspberrypi kernel: scsi host0: usb-storage 1-1.3:1.0
Jun 27 23:37:19 raspberrypi systemd-udevd[29871]: failed to execute '/lib/udev/mtp-probe' 'mtp-probe /sys/devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3 1 17': No such file or directory
Jun 27 23:37:20 raspberrypi kernel: scsi 0:0:0:0: Direct-Access     Drobo    5D               5.00 PQ: 0 ANSI: 0
Jun 27 23:37:20 raspberrypi kernel: scsi 0:0:0:1: Direct-Access     Drobo    5D               5.00 PQ: 0 ANSI: 0
Jun 27 23:37:20 raspberrypi kernel: sd 0:0:0:0: [sda] Very big device. Trying to use READ CAPACITY(16).
Jun 27 23:37:20 raspberrypi kernel: sd 0:0:0:0: [sda] 34359738368 512-byte logical blocks: (17.6 TB/16.0 TiB)
Jun 27 23:37:20 raspberrypi kernel: sd 0:0:0:1: [sdb] 3902799871 512-byte logical blocks: (2.00 TB/1.82 TiB)
Jun 27 23:37:20 raspberrypi kernel: sd 0:0:0:0: [sda] Write Protect is off
Jun 27 23:37:20 raspberrypi kernel: sd 0:0:0:0: [sda] Mode Sense: 03 00 00 00
Jun 27 23:37:20 raspberrypi kernel: sd 0:0:0:1: [sdb] Write Protect is off
Jun 27 23:37:20 raspberrypi kernel: sd 0:0:0:1: [sdb] Mode Sense: 03 00 00 00
Jun 27 23:37:20 raspberrypi kernel: sd 0:0:0:0: [sda] No Caching mode page found
Jun 27 23:37:20 raspberrypi kernel: sd 0:0:0:0: [sda] Assuming drive cache: write through
Jun 27 23:37:20 raspberrypi kernel: sd 0:0:0:1: [sdb] No Caching mode page found
Jun 27 23:37:20 raspberrypi kernel: sd 0:0:0:1: [sdb] Assuming drive cache: write through
Jun 27 23:37:21 raspberrypi kernel: sd 0:0:0:0: [sda] Very big device. Trying to use READ CAPACITY(16).
Jun 27 23:37:21 raspberrypi kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
Jun 27 23:37:21 raspberrypi kernel: sd 0:0:0:1: Attached scsi generic sg1 type 0
Jun 27 23:37:22 raspberrypi kernel:  sda: sda1 sda2
Jun 27 23:37:22 raspberrypi kernel: Alternate GPT is invalid, using primary GPT.
Jun 27 23:37:22 raspberrypi kernel:  sdb: sdb1 sdb2
Jun 27 23:37:22 raspberrypi kernel: sd 0:0:0:1: [sdb] Attached SCSI disk
Jun 27 23:37:23 raspberrypi kernel: hfsplus: write access to a journaled filesystem is not supported, use the force option at your own risk, mounting read-only.
Jun 27 23:37:23 raspberrypi org.gtk.Private.UDisks2VolumeMonitor[1032]: index_parse.c:191: indx_parse(): error opening /media/pi/67f7128a-1664-3b03-baa1-88cf3735347c/BDMV/index.bdmv
Jun 27 23:37:23 raspberrypi org.gtk.Private.UDisks2VolumeMonitor[1032]: index_parse.c:191: indx_parse(): error opening /media/pi/67f7128a-1664-3b03-baa1-88cf3735347c/BDMV/BACKUP/index.bdmv
Jun 27 23:37:23 raspberrypi udisksd[1123]: Mounted /dev/sdb2 at /media/pi/67f7128a-1664-3b03-baa1-88cf3735347c on behalf of uid 1000
```
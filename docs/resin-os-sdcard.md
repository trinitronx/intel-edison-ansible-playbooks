ResinOS SD Card info
====================

In order to use [kubespray](https://github.com/kubernetes-incubator/kubespray), we need to trick it into thinking it is deploying onto CoreOS.  Additionally, we need to make `/opt` writeable for Ansible's python bootstrap steps.

dry-field 6dd9478 192.168.1.140


data microSD card:
## root@6dd9478:~# dmesg -T | grep mmc1
## [Mon Jun 26 01:41:06 2017] mmc1: no vqmmc regulator found
## [Mon Jun 26 01:41:06 2017] mmc1: SDHCI controller on PCI [0000:00:01.2] using ADMA
## [Mon Jun 26 01:50:19 2017] mmc1: SD Status: Invalid Allocation Unit size.
## [Mon Jun 26 01:50:19 2017] mmc1: new high speed SDXC card at address 0007
## [Mon Jun 26 01:50:19 2017] mmcblk1: mmc1:0007 SD128 119 GiB
## Jun 26 01:50:19 6dd9478 kernel: mmc1: SD Status: Invalid Allocation Unit size.
## Jun 26 01:50:19 6dd9478 kernel: mmc1: new high speed SDXC card at address 0007
## Jun 26 01:50:19 6dd9478 kernel: mmcblk1: mmc1:0007 SD128 119 GiB
## Jun 26 01:50:19 6dd9478 kernel:  mmcblk1: p1 p2

$ fdisk /dev/mmcblk1

# Go through menu, make sure to delete any nested disklabel entries
# Create new partition scheme with single Linux partition
Welcome to fdisk (util-linux 2.26.2).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

A hybrid GPT was detected. You have to sync the hybrid MBR manually (expert command 'M').

Command (m for help): x

Expert command (m for help): M

Entering protective/hybrid MBR disklabel.

Expert command (m for help): p
Disk /dev/mmcblk1: 183.4 GiB, 196865949696 bytes, 384503808 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x00000000

Device         Boot  Start       End   Sectors Id Type            Start-C/H/S   End-C/H/S Attrs
/dev/mmcblk1p1           1    409639    409639 ee GPT             1023/63/254 1023/63/254
/dev/mmcblk1p2      409640 384241623 383831984  7 HPFS/NTFS/exFAT 1023/63/254 1023/63/254

Expert command (m for help): M
Leaving nested disklabel.

Expert command (m for help): p
Disk /dev/mmcblk1: 183.4 GiB, 196865949696 bytes, 384503808 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: FBBF6871-4031-4699-BA3D-478F33EB4A6D
First LBA: 34
Last LBA: 384503774
Alternative LBA: 384503807
Partition entries LBA: 2
Allocated partition entries: 128

Device          Start       End   Sectors Type-UUID                            UUID                                 Name                 Attrs
/dev/mmcblk1p1     40    409639    409600 C12A7328-F81F-11D2-BA4B-00A0C93EC93B E148459C-F270-4581-B120-E4B1EB1D88B5 EFI System Partition
/dev/mmcblk1p2 409640 384241623 383831984 EBD0A0A2-B9E5-4433-87C0-68B6B72699C7 9DA2EBFF-AD21-4B68-9455-B360484A1D25 SanDisk200

Expert command (m for help): m

Help (expert commands):

  GPT
   i   change disk GUID
   n   change partition name
   u   change partition UUID
   M   enter protective/hybrid MBR

   A   toggle the legacy BIOS bootable flag
   B   toggle the no block IO protocol flag
   R   toggle the required partition flag
   S   toggle the GUID specific bits

  Generic
   p   print the partition table
   v   verify the partition table
   d   print the raw data of the first sector from the device
   D   print the raw data of the disklabel from the device
   f   fix partitions order
   m   print this menu

  Save & Exit
   q   quit without saving changes
   r   return to main menu


Expert command (m for help): r

Command (m for help): m

Help:

  Generic
   d   delete a partition
   l   list known partition types
   n   add a new partition
   p   print the partition table
   t   change a partition type
   v   verify the partition table

  Misc
   m   print this menu
   x   extra functionality (experts only)

  Script
   I   load disk layout from sfdisk script file
   O   dump disk layout to sfdisk script file

  Save & Exit
   w   write table to disk and exit
   q   quit without saving changes

  Create a new label
   g   create a new empty GPT partition table
   G   create a new empty SGI (IRIX) partition table
   o   create a new empty DOS partition table
   s   create a new empty Sun partition table


Command (m for help): p
Disk /dev/mmcblk1: 183.4 GiB, 196865949696 bytes, 384503808 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: FBBF6871-4031-4699-BA3D-478F33EB4A6D

Device          Start       End   Sectors  Size Type
/dev/mmcblk1p1     40    409639    409600  200M EFI System
/dev/mmcblk1p2 409640 384241623 383831984  183G Microsoft basic data

Command (m for help): v
No errors detected.
Header version: 1.0
Using 2 out of 128 partitions.
A total of 262157 free sectors is available in 2 segments (the largest is 128 MiB).

Command (m for help): d
Partition number (1,2, default 2): 1

Partition 1 has been deleted.

Command (m for help): d
Selected partition 2
Partition 2 has been deleted.

Command (m for help): 2
2: unknown command

Command (m for help): p

Disk /dev/mmcblk1: 183.4 GiB, 196865949696 bytes, 384503808 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: FBBF6871-4031-4699-BA3D-478F33EB4A6D

Command (m for help): x

Expert command (m for help): M
Entering protective/hybrid MBR disklabel.

Expert command (m for help): p
Disk /dev/mmcblk1: 183.4 GiB, 196865949696 bytes, 384503808 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x00000000

Device         Boot  Start       End   Sectors Id Type            Start-C/H/S   End-C/H/S Attrs
/dev/mmcblk1p1           1    409639    409639 ee GPT             1023/63/254 1023/63/254
/dev/mmcblk1p2      409640 384241623 383831984  7 HPFS/NTFS/exFAT 1023/63/254 1023/63/254

Expert command (m for help): d

First sector: offset = 0, size = 512 bytes.
00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
*
000001b0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 fe
000001c0  ff ff ee fe ff ff 01 00  00 00 27 40 06 00 00 fe
000001d0  ff ff 07 fe ff ff 28 40  06 00 b0 cf e0 16 00 00
000001e0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa

Expert command (m for help): r

Command (m for help): d
Partition number (1,2, default 2): 1

Partition 1 has been deleted.

Command (m for help): d
Selected partition 2
Partition 2 has been deleted.

Command (m for help): p
Disk /dev/mmcblk1: 183.4 GiB, 196865949696 bytes, 384503808 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x00000000

Command (m for help): m

Help:

  DOS (MBR)
   a   toggle a bootable flag
   b   edit nested BSD disklabel
   c   toggle the dos compatibility flag

  Generic
   d   delete a partition
   l   list known partition types
   n   add a new partition
   p   print the partition table
   t   change a partition type
   v   verify the partition table

  Misc
   m   print this menu
   u   change display/entry units
   x   extra functionality (experts only)

  Script
   I   load disk layout from sfdisk script file
   O   dump disk layout to sfdisk script file

  Save & Exit
   w   write table to disk and exit
   q   quit without saving changes

You're editing nested 'dos' partition table, primary partition table is 'gpt'.

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1): 1
First sector (1-384503807, default 34): 4096
Last sector, +sectors or +size{K,M,G,T,P} (4096-384503807, default 384503807):

Created a new partition 1 of type 'Linux' and of size 183.4 GiB.

Command (m for help): p
Disk /dev/mmcblk1: 183.4 GiB, 196865949696 bytes, 384503808 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x00000000

Device         Boot Start       End   Sectors   Size Id Type
/dev/mmcblk1p1       4096 384503807 384499712 183.4G 83 Linux

Command (m for help): x

Expert command (m for help): M
Leaving nested disklabel.

Expert command (m for help): p
Disk /dev/mmcblk1: 183.4 GiB, 196865949696 bytes, 384503808 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: FBBF6871-4031-4699-BA3D-478F33EB4A6D
First LBA: 34
Last LBA: 384503774
Alternative LBA: 384503807
Partition entries LBA: 2
Allocated partition entries: 128

Expert command (m for help): r

Command (m for help): p
Disk /dev/mmcblk1: 183.4 GiB, 196865949696 bytes, 384503808 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: FBBF6871-4031-4699-BA3D-478F33EB4A6D

Command (m for help): p
Disk /dev/mmcblk1: 183.4 GiB, 196865949696 bytes, 384503808 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: FBBF6871-4031-4699-BA3D-478F33EB4A6D

Command (m for help): m

Help:

  Generic
   d   delete a partition
   l   list known partition types
   n   add a new partition
   p   print the partition table
   t   change a partition type
   v   verify the partition table

  Misc
   m   print this menu
   x   extra functionality (experts only)

  Script
   I   load disk layout from sfdisk script file
   O   dump disk layout to sfdisk script file

  Save & Exit
   w   write table to disk and exit
   q   quit without saving changes

  Create a new label
   g   create a new empty GPT partition table
   G   create a new empty SGI (IRIX) partition table
   o   create a new empty DOS partition table
   s   create a new empty Sun partition table


Command (m for help): d
No partition is defined yet!
Could not delete partition 1

Command (m for help): g

Created a new GPT disklabel (GUID: DA084CDD-6FA5-4685-A294-6B54FCEAB72D).

Command (m for help): p
Disk /dev/mmcblk1: 183.4 GiB, 196865949696 bytes, 384503808 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: DA084CDD-6FA5-4685-A294-6B54FCEAB72D

Command (m for help): p
Disk /dev/mmcblk1: 183.4 GiB, 196865949696 bytes, 384503808 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: DA084CDD-6FA5-4685-A294-6B54FCEAB72D

Command (m for help): x

Expert command (m for help): M
Entering protective/hybrid MBR disklabel.

Expert command (m for help): p
Disk /dev/mmcblk1: 183.4 GiB, 196865949696 bytes, 384503808 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x00000000

Device         Boot Start       End   Sectors Id Type Start-C/H/S   End-C/H/S Attrs
/dev/mmcblk1p1          1 384503807 384503807 ee GPT        0/1/0 1023/63/254

Expert command (m for help): d

First sector: offset = 0, size = 512 bytes.
00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
*
000001b0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 fe
000001c0  ff ff ee fe ff ff 01 00  00 00 27 40 06 00 00 fe
000001d0  ff ff 07 fe ff ff 28 40  06 00 b0 cf e0 16 00 00
000001e0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa

Expert command (m for help): r

Command (m for help): d
Selected partition 1
Partition 1 has been deleted.

Command (m for help): x

Expert command (m for help): M
Leaving nested disklabel.

Expert command (m for help): p
Disk /dev/mmcblk1: 183.4 GiB, 196865949696 bytes, 384503808 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: DA084CDD-6FA5-4685-A294-6B54FCEAB72D
First LBA: 2048
Last LBA: 384503774
Alternative LBA: 384503807
Partition entries LBA: 2
Allocated partition entries: 128

Expert command (m for help): r

Command (m for help): g
Created a new GPT disklabel (GUID: 8271EC0A-8FD1-4410-AC3D-3A27B45DFF6D).

Command (m for help): p
Disk /dev/mmcblk1: 183.4 GiB, 196865949696 bytes, 384503808 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 8271EC0A-8FD1-4410-AC3D-3A27B45DFF6D

Command (m for help): x

Expert command (m for help): M
Entering protective/hybrid MBR disklabel.

Expert command (m for help): p
Disk /dev/mmcblk1: 183.4 GiB, 196865949696 bytes, 384503808 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x00000000

Device         Boot Start       End   Sectors Id Type Start-C/H/S   End-C/H/S Attrs
/dev/mmcblk1p1          1 384503807 384503807 ee GPT        0/1/0 1023/63/254

Expert command (m for help): r

Command (m for help): M
M: unknown command

Command (m for help): x

Expert command (m for help): M

Leaving nested disklabel.

Expert command (m for help): p
Disk /dev/mmcblk1: 183.4 GiB, 196865949696 bytes, 384503808 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 8271EC0A-8FD1-4410-AC3D-3A27B45DFF6D
First LBA: 2048
Last LBA: 384503774
Alternative LBA: 384503807
Partition entries LBA: 2
Allocated partition entries: 128

Expert command (m for help): r

Command (m for help): m

Help:

  Generic
   d   delete a partition
   l   list known partition types
   n   add a new partition
   p   print the partition table
   t   change a partition type
   v   verify the partition table

  Misc
   m   print this menu
   x   extra functionality (experts only)

  Script
   I   load disk layout from sfdisk script file
   O   dump disk layout to sfdisk script file

  Save & Exit
   w   write table to disk and exit
   q   quit without saving changes

  Create a new label
   g   create a new empty GPT partition table
   G   create a new empty SGI (IRIX) partition table
   o   create a new empty DOS partition table
   s   create a new empty Sun partition table


Command (m for help): n
Partition number (1-128, default 1): 1
First sector (2048-384503774, default 2048): 4096
Last sector, +sectors or +size{K,M,G,T,P} (4096-384503774, default 384503774):

Created a new partition 1 of type 'Linux filesystem' and of size 183.4 GiB.

Command (m for help): p
Disk /dev/mmcblk1: 183.4 GiB, 196865949696 bytes, 384503808 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 8271EC0A-8FD1-4410-AC3D-3A27B45DFF6D

Device         Start       End   Sectors   Size Type
/dev/mmcblk1p1  4096 384503774 384499679 183.4G Linux filesystem

Command (m for help): x

Expert command (m for help): M
Entering protective/hybrid MBR disklabel.

Expert command (m for help): p
Disk /dev/mmcblk1: 183.4 GiB, 196865949696 bytes, 384503808 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x00000000

Device         Boot Start       End   Sectors Id Type Start-C/H/S   End-C/H/S Attrs
/dev/mmcblk1p1          1 384503807 384503807 ee GPT        0/1/0 1023/63/254

Expert command (m for help): M
Leaving nested disklabel.

Expert command (m for help): r

Command (m for help): p
Disk /dev/mmcblk1: 183.4 GiB, 196865949696 bytes, 384503808 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 8271EC0A-8FD1-4410-AC3D-3A27B45DFF6D

Device         Start       End   Sectors   Size Type
/dev/mmcblk1p1  4096 384503774 384499679 183.4G Linux filesystem

Command (m for help): m

Help:

  Generic
   d   delete a partition
   l   list known partition types
   n   add a new partition
   p   print the partition table
   t   change a partition type
   v   verify the partition table

  Misc
   m   print this menu
   x   extra functionality (experts only)

  Script
   I   load disk layout from sfdisk script file
   O   dump disk layout to sfdisk script file

  Save & Exit
   w   write table to disk and exit
   q   quit without saving changes

  Create a new label
   g   create a new empty GPT partition table
   G   create a new empty SGI (IRIX) partition table
   o   create a new empty DOS partition table
   s   create a new empty Sun partition table


Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.

root@34493e1:~# mkfs -h

Usage:
 mkfs [options] [-t <type>] [fs-options] <device> [<size>]

Make a Linux filesystem.

Options:
 -t, --type=<type>  filesystem type; when unspecified, ext2 is used
     fs-options     parameters for the real filesystem builder
     <device>       path to the device to be used
     <size>         number of blocks to be used on the device
 -V, --verbose      explain what is being done;
                      specifying -V more than once will cause a dry-run
 -V, --version      display version information and exit;
                      -V as --version must be the only option
 -h, --help         display this help text and exit

For more details see mkfs(8).


$ mkfs --verbose -t ext4 -L resin-data /dev/mmcblk1p1

mkfs from util-linux 2.26.2
mkfs.ext4 /dev/mmcblk1p1
mke2fs 1.42.9 (28-Dec-2013)
Discarding device blocks:     4096/48062459
  528384/48062459
 1052672/48062459
 2101248/48062459
23597056/48062459
24121344/48062459
done
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
Stride=0 blocks, Stripe width=0 blocks
12017664 inodes, 48062459 blocks
2403122 blocks (5.00%) reserved for the super user
First data block=0
Maximum filesystem blocks=0
1467 block groups
32768 blocks per group, 32768 fragments per group
8192 inodes per group
Superblock backups stored on blocks:
	32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
	4096000, 7962624, 11239424, 20480000, 23887872

Allocating group tables: done
Writing inode tables: done
Creating journal (32768 blocks): done
Writing superblocks and filesystem accounting information: done


# Re-Mount root read / write

$ mount -o remount,rw /

$ mkdir /opt

# Sync /mnt/data to our SD Card:
$ mount /dev/mmcblk1p1 /opt/

$ rsync -av  /mnt/data/ /opt/
sending incremental file list

docker/....
docker/....
docker/....
...

sent 230,088 bytes  received 1,401 bytes  154,326.00 bytes/sec
total size is 78,835,736  speedup is 340.56

$ systemctl stop resin-supervisor.service
$ systemctl stop openvpn-resin.service
$ docker ps -aq | awk '{ print $1 }' | xargs docker rm -v

$ systemctl stop docker

# Re-sync the rest of the files
$ rsync -av --delete /mnt/data/ /opt/
sending incremental file list

docker/....
docker/....
docker/....
...

sent 230,088 bytes  received 1,401 bytes  154,326.00 bytes/sec
total size is 78,835,736  speedup is 340.56


# Rename partition label to 'resin-data'

$ fdisk /dev/mmcblk1

Welcome to fdisk (util-linux 2.26.2).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.


Command (m for help): p
Disk /dev/mmcblk1: 119.6 GiB, 128396034048 bytes, 250773504 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 4B1D83A2-C568-49C2-9BFC-204B3B1E4B31

Device         Start       End   Sectors   Size Type
/dev/mmcblk1p1  4096 250773470 250769375 119.6G Linux filesystem

Command (m for help): m

Help:

  Generic
   d   delete a partition
   l   list known partition types
   n   add a new partition
   p   print the partition table
   t   change a partition type
   v   verify the partition table

  Misc
   m   print this menu
   x   extra functionality (experts only)

  Script
   I   load disk layout from sfdisk script file
   O   dump disk layout to sfdisk script file

  Save & Exit
   w   write table to disk and exit
   q   quit without saving changes

  Create a new label
   g   create a new empty GPT partition table
   G   create a new empty SGI (IRIX) partition table
   o   create a new empty DOS partition table
   s   create a new empty Sun partition table


Command (m for help): v
No errors detected.
Header version: 1.0
Using 1 out of 128 partitions.
A total of 4062 free sectors is available in 1 segment.

Command (m for help): x

Expert command (m for help): m

Help (expert commands):

  GPT
   i   change disk GUID
   n   change partition name
   u   change partition UUID
   M   enter protective/hybrid MBR

   A   toggle the legacy BIOS bootable flag
   B   toggle the no block IO protocol flag
   R   toggle the required partition flag
   S   toggle the GUID specific bits

  Generic
   p   print the partition table
   v   verify the partition table
   d   print the raw data of the first sector from the device
   D   print the raw data of the disklabel from the device
   f   fix partitions order
   m   print this menu

  Save & Exit
   q   quit without saving changes
   r   return to main menu


Expert command (m for help): n
Selected partition 1

New name: resin-data

Partition name changed from '' to 'resin-data'.

Expert command (m for help): r

Command (m for help): w

The partition table has been altered.
Calling ioctl() to re-read partition table.
Re-reading the partition table failed.: Device or resource busy

The kernel still uses the old table. The new table will be used at the next reboot or after you run partprobe(8) or kpartx(8).

# Label the new FS as resin-data
$ e2label /dev/mmcblk1p1 resin-data



# Now rename the old resin-data on the Intel Edison to 'resin-data-OLD'

$ fdisk /dev/mmcblk0

Welcome to fdisk (util-linux 2.26.2).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.


Command (m for help): p
Disk /dev/mmcblk0: 3.7 GiB, 3909091328 bytes, 7634944 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 21200400-0804-0146-9DCC-A8C51255994F

Device            Start     End Sectors  Size Type
/dev/mmcblk0p1     2048    6143    4096    2M Microsoft basic data
/dev/mmcblk0p2     6144    8191    2048    1M Microsoft basic data
/dev/mmcblk0p3     8192   12287    4096    2M Microsoft basic data
/dev/mmcblk0p4    12288   14335    2048    1M Microsoft basic data
/dev/mmcblk0p5    14336   16383    2048    1M Microsoft basic data
/dev/mmcblk0p6    16384   65535   49152   24M Microsoft basic data
/dev/mmcblk0p7    65536  147455   81920   40M Microsoft basic data
/dev/mmcblk0p8   147456  786431  638976  312M Microsoft basic data
/dev/mmcblk0p9   786432 1425407  638976  312M Microsoft basic data
/dev/mmcblk0p10 1425408 1466367   40960   20M Microsoft basic data
/dev/mmcblk0p11 1466368 7634910 6168543    3G Microsoft basic data

Command (m for help): x

Expert command (m for help): p
Disk /dev/mmcblk0: 3.7 GiB, 3909091328 bytes, 7634944 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 21200400-0804-0146-9DCC-A8C51255994F
First LBA: 34
Last LBA: 7634910
Alternative LBA: 7634943
Partition entries LBA: 2
Allocated partition entries: 128

Device            Start     End Sectors Type-UUID                            UUID                                 Name        Attrs
/dev/mmcblk0p1     2048    6143    4096 EBD0A0A2-B9E5-4433-87C0-68B6B72699C7 D117F98E-6F2C-D04B-A5B2-331A19F91CB2 u-boot0
/dev/mmcblk0p2     6144    8191    2048 EBD0A0A2-B9E5-4433-87C0-68B6B72699C7 25718777-D0AD-7443-9E60-02CB591C9737 u-boot-env0
/dev/mmcblk0p3     8192   12287    4096 EBD0A0A2-B9E5-4433-87C0-68B6B72699C7 8A4BB8B4-E304-AE48-8536-AFF5C9C495B1 u-boot1
/dev/mmcblk0p4    12288   14335    2048 EBD0A0A2-B9E5-4433-87C0-68B6B72699C7 08992135-13C6-084B-9322-3391FF571E19 u-boot-env1
/dev/mmcblk0p5    14336   16383    2048 EBD0A0A2-B9E5-4433-87C0-68B6B72699C7 333A128E-D3E3-B94D-92F4-D3EBD9B3224F factory
/dev/mmcblk0p6    16384   65535   49152 EBD0A0A2-B9E5-4433-87C0-68B6B72699C7 F20AA902-1C5D-294A-9177-97A513E3CAE4 panic
/dev/mmcblk0p7    65536  147455   81920 EBD0A0A2-B9E5-4433-87C0-68B6B72699C7 DB88503D-34A5-3E41-836D-C757CB682814 resin-boot
/dev/mmcblk0p8   147456  786431  638976 EBD0A0A2-B9E5-4433-87C0-68B6B72699C7 012B3303-34AC-284D-99B4-34E03A2335F4 resin-rootA
/dev/mmcblk0p9   786432 1425407  638976 EBD0A0A2-B9E5-4433-87C0-68B6B72699C7 FAEC2ECF-8544-E241-B19D-757E796DA607 resin-rootB
/dev/mmcblk0p10 1425408 1466367   40960 EBD0A0A2-B9E5-4433-87C0-68B6B72699C7 F13A0978-B1B5-1A4E-8821-39438E24B627 resin-state
/dev/mmcblk0p11 1466368 7634910 6168543 EBD0A0A2-B9E5-4433-87C0-68B6B72699C7 B710EB04-45B9-E94A-8D0B-21458D596F54 resin-data

Expert command (m for help): m

Help (expert commands):

  GPT
   i   change disk GUID
   n   change partition name
   u   change partition UUID
   M   enter protective/hybrid MBR

   A   toggle the legacy BIOS bootable flag
   B   toggle the no block IO protocol flag
   R   toggle the required partition flag
   S   toggle the GUID specific bits

  Generic
   p   print the partition table
   v   verify the partition table
   d   print the raw data of the first sector from the device
   D   print the raw data of the disklabel from the device
   f   fix partitions order
   m   print this menu

  Save & Exit
   q   quit without saving changes
   r   return to main menu


Expert command (m for help): v
No errors detected.
Header version: 1.0
Using 11 out of 128 partitions.
A total of 2014 free sectors is available in 1 segment.

Expert command (m for help): n
Partition number (1-11, default 11): 11

New name: resin-data-OLD

Partition name changed from 'resin-data' to 'resin-data-OLD'.

Expert command (m for help): w
w: unknown command

Expert command (m for help): m

Help (expert commands):

  GPT
   i   change disk GUID
   n   change partition name
   u   change partition UUID
   M   enter protective/hybrid MBR

   A   toggle the legacy BIOS bootable flag
   B   toggle the no block IO protocol flag
   R   toggle the required partition flag
   S   toggle the GUID specific bits

  Generic
   p   print the partition table
   v   verify the partition table
   d   print the raw data of the first sector from the device
   D   print the raw data of the disklabel from the device
   f   fix partitions order
   m   print this menu

  Save & Exit
   q   quit without saving changes
   r   return to main menu


Expert command (m for help): r

Command (m for help): w

The partition table has been altered.
Calling ioctl() to re-read partition table.
Re-reading the partition table failed.: Device or resource busy

The kernel still uses the old table. The new table will be used at the next reboot or after you run partprobe(8) or kpartx(8).

## FS Label needs to be changed (This seems to be used by udev /lib/udev/rules.d/60-persistent-storage.rules)
root@6dd9478:~# e2label /dev/mmcblk0p11
resin-data

# Change ext4 FS label
root@6dd9478:~# e2label /dev/mmcblk0p11 resin-data-OLD
root@6dd9478:~# e2label /dev/mmcblk0p11
resin-data-OLD

# Reboot to use new SD card as 'resin-data'
$ systemctl reboot



VERIFICATION
============

To check whether the new disk has been mounted correctly, make sure you see `mmcblk1p1` in the output of `mount` command:

```
root@34493e1:~# mount
proc on /proc type proc (rw,relatime)
sysfs on /sys type sysfs (rw,relatime)
devtmpfs on /dev type devtmpfs (rw,relatime,size=486608k,nr_inodes=121652,mode=755)
/dev/mmcblk0p8 on / type ext4 (ro,nodev,noatime,discard,noauto_da_alloc,data=ordered)
/dev/mmcblk0p10 on /mnt/state type ext4 (rw,relatime,data=ordered)
/dev/mmcblk0p10 on /etc/machine-id type ext4 (rw,relatime,data=ordered)
tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev)
devpts on /dev/pts type devpts (rw,relatime,gid=5,mode=620,ptmxmode=000)
tmpfs on /run type tmpfs (rw,nosuid,nodev,mode=755)
tmpfs on /sys/fs/cgroup type tmpfs (ro,nosuid,nodev,noexec,mode=755)
cgroup on /sys/fs/cgroup/systemd type cgroup (rw,nosuid,nodev,noexec,relatime,xattr,release_agent=/lib/systemd/systemd-cgroups-agent,name=systemd)
pstore on /sys/fs/pstore type pstore (rw,nosuid,nodev,noexec,relatime)
cgroup on /sys/fs/cgroup/perf_event type cgroup (rw,nosuid,nodev,noexec,relatime,perf_event)
cgroup on /sys/fs/cgroup/memory type cgroup (rw,nosuid,nodev,noexec,relatime,memory)
cgroup on /sys/fs/cgroup/cpu,cpuacct type cgroup (rw,nosuid,nodev,noexec,relatime,cpuacct,cpu)
cgroup on /sys/fs/cgroup/devices type cgroup (rw,nosuid,nodev,noexec,relatime,devices)
cgroup on /sys/fs/cgroup/freezer type cgroup (rw,nosuid,nodev,noexec,relatime,freezer)
cgroup on /sys/fs/cgroup/blkio type cgroup (rw,nosuid,nodev,noexec,relatime,blkio)
cgroup on /sys/fs/cgroup/cpuset type cgroup (rw,nosuid,nodev,noexec,relatime,cpuset)
mqueue on /dev/mqueue type mqueue (rw,relatime)
tmpfs on /tmp type tmpfs (rw)
debugfs on /sys/kernel/debug type debugfs (rw,relatime)
fusectl on /sys/fs/fuse/connections type fusectl (rw,relatime)
configfs on /sys/kernel/config type configfs (rw,relatime)
tmpfs on /var/volatile type tmpfs (rw,relatime)
tmpfs on /var/lib type tmpfs (rw,relatime)
/dev/mmcblk0p7 on /mnt/boot type vfat (rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)
/dev/mmcblk0p10 on /etc/resin-supervisor type ext4 (rw,relatime,data=ordered)
/dev/mmcblk0p10 on /etc/systemd/system/resin.target.wants type ext4 (rw,relatime,data=ordered)
/dev/mmcblk0p10 on /etc/docker type ext4 (rw,relatime,data=ordered)
/dev/mmcblk0p10 on /home/root/.docker type ext4 (rw,relatime,data=ordered)
/dev/mmcblk0p10 on /etc/hostname type ext4 (rw,relatime,data=ordered)
/dev/mmcblk0p10 on /etc/NetworkManager/system-connections type ext4 (rw,relatime,data=ordered)
/dev/mmcblk0p10 on /home/root/.rnd type ext4 (rw,relatime,data=ordered)
/dev/mmcblk0p5 on /factory type ext4 (ro,noatime)
/dev/mmcblk1p1 on /mnt/data type ext4 (rw,relatime,data=ordered)
/dev/mmcblk1p1 on /resin-data type ext4 (rw,relatime,data=ordered)
/dev/mmcblk1p1 on /var/lib/docker type ext4 (rw,relatime,data=ordered)
/dev/mmcblk1p1 on /var/volatile/lib/docker type ext4 (rw,relatime,data=ordered)
/dev/mmcblk0p10 on /etc/dropbear type ext4 (rw,relatime,data=ordered)
```

Udev should have mounted the device by the new label:

```
root@34493e1:~# ls -l /dev/disk/by-label/
total 0
lrwxrwxrwx 1 root root 15 Jan  1  2000 resin-boot -> ../../mmcblk0p7
lrwxrwxrwx 1 root root 15 Jan  1  2000 resin-data -> ../../mmcblk1p1
lrwxrwxrwx 1 root root 16 Jan  1  2000 resin-data-OLD -> ../../mmcblk0p11
lrwxrwxrwx 1 root root 15 Jan  1  2000 resin-rootA -> ../../mmcblk0p8
lrwxrwxrwx 1 root root 16 Jan  1  2000 resin-state -> ../../mmcblk0p10
```

The SystemD unit responsible for mounting:

```
root@34493e1:~# systemctl status mnt-data.mount
● mnt-data.mount - Resin data partition mountpoint
   Loaded: loaded (/lib/systemd/system/mnt-data.mount; enabled; vendor preset: enabled)
   Active: active (mounted) since Sat 2000-01-01 00:00:20 UTC; 17 years 5 months ago
    Where: /mnt/data
     What: /dev/mmcblk1p1
  Process: 614 ExecMount=/bin/mount /dev/disk/by-label/resin-data /mnt/data -t ext4 (code=exited, status=0/SUCCESS)

Jan 01 00:00:20 edison systemd[1]: Mounting Resin data partition mountpoint...
Jan 01 00:00:20 edison systemd[1]: Mounted Resin data partition mountpoint.
```

Docker's storage directory `/var/lib/docker` should have been mounted:

```
root@34493e1:~# cat /lib/systemd/system/var-lib-docker.mount
[Unit]
Description=Docker data mountpoint
Requires=mnt-data.mount var-volatile-lib.service
After=mnt-data.mount var-volatile-lib.service

[Mount]
What=/mnt/data/docker
Where=/var/lib/docker
Type=none
Options=bind

[Install]
WantedBy=multi-user.target
```


We will create a new mount for `/opt`:

```
root@34493e1:~# mkdir /mnt/data/opt/
root@34493e1:~# cat /lib/systemd/system/opt.mount
[Unit]
Description=Opt data mountpoint
Requires=mnt-data.mount
After=mnt-data.mount

[Mount]
What=/mnt/data/opt
Where=/opt
Type=none
Options=bind

[Install]
WantedBy=multi-user.target
```

Enable `opt.mount`:

```
root@34493e1:~# systemctl enable opt.mount
Created symlink from /etc/systemd/system/multi-user.target.wants/opt.mount to /lib/systemd/system/opt.mount.
root@6dd9478:~# systemctl daemon-reload
root@6dd9478:~# systemctl status opt.mount
● opt.mount - Opt data mountpoint
   Loaded: loaded (/lib/systemd/system/opt.mount; enabled; vendor preset: enabled)
   Active: inactive (dead)
    Where: /opt
     What: /mnt/data/opt
```

Reboot again to test everything comes up ok:

```
$ systemctl reboot

[... WAIT ...]

root@6dd9478:~# systemctl status opt.mount
● opt.mount - Opt data mountpoint
   Loaded: loaded (/lib/systemd/system/opt.mount; enabled; vendor preset: enabled)
   Active: active (mounted) since Tue 2017-06-27 04:11:33 UTC; 1min 22s ago
    Where: /opt
     What: /dev/mmcblk1p1
  Process: 610 ExecMount=/bin/mount /mnt/data/opt /opt -t none -o bind (code=exited, status=0/SUCCESS)

Jun 27 04:11:33 edison systemd[1]: Mounting Opt data mountpoint...
Jun 27 04:11:33 edison systemd[1]: Mounted Opt data mountpoint.
```
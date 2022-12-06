#!/bin/bash


# setting up btrfs
cfdisk /dev/sda
mkfs.btrfs -L -f root /dev/sda2
mkfs.fat -F32 /dev/sda1
#mounting the drive to setup subvolumes
mount /dev/sda2 /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@btrfs
btrfs su cr /mnt/@snapshots
# mount drive
umount /dev/sda2
# mounting subvolumes
mount -o compress=lzo,relatime,subvol=@ /dev/sda2 /mnt
mkdir /mnt/home
mount -o compress=lzo,relatime,subvol=@home /dev/sda2 /mnt/@home
mount -o compress=lzo,relatime,subvolid=5 /dev/sda2 /mnt/@btrfs
# mount boot partition 
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
# thank you for using this script 
echo $'\n'$"*** All done with subvolumes. ***"

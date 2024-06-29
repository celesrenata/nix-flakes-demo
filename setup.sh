#!/usr/bin/env bash
# to create the partitions programatically (rather than manually)
# we're going to simulate the manual input to fdisk
# The sed script strips off all the comments so that we can
# document what we're doing in-line with the actual commands
# Note that a blank line (commented as "defualt" will send a empty
# line terminated with a newline to take the fdisk default.
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk /dev/vda
  g # clear the in memory partition table
  n # new partition
  p # primary partition
  1 # partition number 1
    # default - start at beginning of disk
  +256M # 256 MB boot parttion
  n # new partition
  p # primary partition
  2 # partion number 2
    # default, start immediately after preceding partition
  +8G  # 8 GB swap partition
  n # new partition
  p # primary partition
  3 # partion number 3
    # default, start immediately after preceding partition
    # the rest of the disk
  t # type
  1 #
  uefi #
  t # type
  2 #
  swap #
  t # type
  3 #
  linux #
  w # write the partition table
  q # and we're done
EOF


mkfs.fat -F32 /dev/vda1
mkswap /dev/vda2
swapon /dev/vda2
mkfs.btrfs /dev/vda3
mount /dev/vda3 /mnt
cd /mnt
btrfs subvol create root
btrfs subvol create home
btrfs subvol create nix
btrfs subvol create workplace
cd ..
umount /mnt
mount -o compress=zstd,subvol=root /dev/vda3 /mnt
mkdir /mnt/{boot,nix,home,workplace}
mount -o compress=zstd,subvol=home /dev/vda3 /mnt/home
mount -o compress=zstd,subvol=nix /dev/vda3 /mnt/nix
mount -o compress=zstd,subvol=workplace /dev/vda3 /mnt/workplace
mount /dev/vda1 /mnt/boot
nixos-generate-config --root /mnt

# NixOS for Mac T2

## Installation
1. Read the following instructions to familiarize yourself with NixOS https://wiki.t2linux.org/distributions/nixos/home/
1. Download https://github.com/t2linux/nixos-t2-iso/releases/download/v6.9.8-1/nixos-t2-iso-minimal.iso
2. dd to thumbdrive `sudo dd if=nixos-t2-iso-minimal.iso of=/dev/sdX status=progress` (use /dev/rdiskX if in macOS)
3. Resize the AFPS partition to allow for 256G+ partition
4. Press and hold 'Option' with the thumbdrive insearted at boot
5. Select EFI boot
6. Boot thumbdrive
7. Delete new partition
8. Create 2 new partitions (16G for swap 256G+ for root) on /dev/nvme0n1
  1. `p` # list partitions
  2. `d` # delete created linux partition by MacOS
     1. Choose the number assosicated with the new parition
  1.  `n` # new partition
  1. partition number (default)
  1. default - start at beginning of disk
  1. `+16G` # 16 GB swap parttion
  1. `n` # new partition
  1. partition number (default)
  1. default, start immediately after preceding partition
  1. default, # the rest of the disk
  1. `t` # type
  1. choose the swap partition you created
  1. `swap`
  1. `t` # type
  1. choose the new root partition you created
  1. `linux`
  1. `w` # write the partition table
  1. This is the assumed location of the swap partition, enable swap! `mkswap /dev/nvme0n1p3`
  1. `swapon /dev/nvme0n1p3`
  1. This is the assumed location of the new root partition, `mkfs.btrfs /dev/nvme0n1p4`
  1. `mount /dev/nvme0n1p4 /mnt`
  1. `cd /mnt`
  1. `btrfs subvol create root`
  1. `btrfs subvol create home`
  1. `btrfs subvol create nix`
  1. `btrfs subvol create workplace`
  1. `cd ..`
  1. `umount /mnt`
  1. `mount -o compress=zstd,subvol=root /dev/nvme0n1p4 /mnt`
  1. `mkdir /mnt/{boot,nix,home,workplace}`
  1. `mount -o compress=zstd,subvol=home /dev/vda3 /mnt/home`
  1. `mount -o compress=zstd,subvol=nix /dev/vda3 /mnt/nix`
  1. `mount -o compress=zstd,subvol=workplace /dev/vda3 /mnt/workplace`
  1. `mount /dev/nvme0n1p1 /mnt/boot/EFI`
  1. `nixos-generate-config --root /mnt`
  1. add "compress=zstd" to btrfs options lines in `vim /mnt/etc/nixos/hardware-configuration.nix`
  1. download the flakes! `git clone https://github.com/celesrenata/nix-flakes-demo --branch locked-state-t2`
  1. `cd nix-flakes-demo`
  1. `cp -r * /mnt/etc/nixos/
  1. install the system! `sudo nixos-install --root /mnt --flake /mnt/etc/nixos#macland`
   7. `reboot`
   8. Login with demo:demo
   9. System will reboot and configure itself and reboot
   10. Login again.
   11. give the system 10 minutes to provision windows (installation observable from https://127.0.0.1:8006)
   12. run `winapps/runmefirst.sh` to install m365 and configure for your system
      1. It knows when it is provisioned!
   13. in another 10 minutes once m365 is installed, the script will hang after the m365 install window goes away, press 'ctrl + c'
   14. either restart the script or continue if it says 'User'
   15. From here install all pre-configured detected apps
   16. Install the rest if you don't mind doubles
   17. 'Control + Command + R' to reload new xdg apps
   18. Good to go!

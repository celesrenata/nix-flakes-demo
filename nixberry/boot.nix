{ config, lib, pkgs, ... }:
{
  config = {
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = false;
        grub.device = "nodev";
        grub.efiSupport = true;
      };
      supportedFilesystems = [ "ext4" "cifs" "ntfs" "nfs" ];
      kernelPackages = pkgs.linuxPackages_latest;
      kernelParams = [ "8250.nr_uarts=11" "console=ttyAMA10,9660" "console=tty0" ];
      kernelModules = [ "uinput" ];
    };
  };
}

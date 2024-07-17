{ ... }:
{
  config = {
    boot = {
      loader = {
        efi.efiSysMountPoint = "/boot/EFI";
        grub = {
          enable = true;
          efiSupport = true;
          efiInstallAsRemovable = true;
          device = "nodev";
        };
      };
      supportedFilesystems = [ "ntfs" "nfs" ];
      #kernelPackages = pkgs.t2Kernel;
      kernelModules = [ "uinput" "amdgpu" ];
    };
  };
}

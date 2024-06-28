{ config, modulesPath, lib, pkgs, pkgs-unstable, ... }:
{
  #imports = [(modulesPath + "/virtualisation/qemu-vm.nix")];

  config = {
                      
    # virtualisation.qemu.options = [
    #   "-device virtio-vga-gl-pci"
    #   "-display sdl,gl=on,show-cursor=off"
    #   "-full-screen"
    #   "-spice port=5924,disable-ticketing=on"
    #   "-device virtio-serial -chardev spicevmc,id=vdagent,debug=0,name=vdagent"
    #   "-device virtserialport,chardev=vdagent,name=com.redhat.spice.0"
    # ];

    virtualisation.libvirtd.qemu.enable = true;
    services.spice-webdavd.enable = true;
    services.qemuGuest.enable = true;
    services.davfs2 = {
      enable = true;
      settings = {
        globalSection = {
          ask_auth = "0";
        };
      };
    };
  };
}

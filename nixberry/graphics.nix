{ config, lib, pkgs, nixpkgs,  ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      libGL
      mesa
    ];
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        mesa
      ];
    };

    # VMware SVGA II graphics driver
    services.xserver.videoDrivers = [ "vmware" ];
  };
}

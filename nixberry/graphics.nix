{ config, lib, pkgs, nixpkgs,  ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      libGL
    ];
    hardware.opengl = {
      enable = true;
      extraPackages = with pkgs; [
        libvdpau-va-gl
        libGL
      ];
    };

    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = [ "virgl" ];
  };
}

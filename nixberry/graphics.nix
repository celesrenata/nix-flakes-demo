{ config, lib, pkgs, nixpkgs,  ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      libGL
    ];
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        libGL
      ];
    };

    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = [ "virgl" ];
  };
}

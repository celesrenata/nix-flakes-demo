{ config, lib, pkgs, nixpkgs,  ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      libGL
      mesa
    ];
    hardware.opengl.enable = true;
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        mesa
      ];
    };

    # Use modesetting driver for VMware Fusion on ARM64
    services.xserver.videoDrivers = [ "modesetting" ];
  };
}

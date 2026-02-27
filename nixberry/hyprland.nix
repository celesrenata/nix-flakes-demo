# Hyprland configuration for nixberry
{ inputs, lib, pkgs, pkgs-unstable, config, ... }:

{
  imports = [ 
    inputs.dots-hyprland.homeManagerModules.default
  ];

  # dots-hyprland configuration for nixberry
  programs.dots-hyprland = {
    enable = true;
    source = inputs.dots-hyprland-source + "/.config";
    packageSet = "essential";
    mode = "hybrid";
    
    python.enable = true;
    touchegg.enable = lib.mkForce false;
    configuration.copyMiscConfig = lib.mkForce true;
    configuration.applications.foot.enable = lib.mkForce false;
    configuration.applications.kitty.enable = lib.mkForce false;
    configuration.applications.fuzzel.enable = lib.mkForce false;
    configuration.copyFishConfig = lib.mkForce false;
  };
}

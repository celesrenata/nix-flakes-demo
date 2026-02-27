{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    anyrun.url = "github:Kirottu/anyrun";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    dream2nix.url = "github:nix-community/dream2nix";
    uniclip.url = "github:celesrenata/uniclip";
    quickshell.url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    dots-hyprland.url = "github:celesrenata/end-4-flakes";
    dots-hyprland.inputs.nixpkgs.follows = "nixpkgs";
    dots-hyprland-source.url = "github:celesrenata/dots-hyprland/quickshell";
    dots-hyprland-source.flake = false;
  };

  outputs = inputs@{ nixpkgs, nixpkgs-stable, nixpkgs-unstable, anyrun, home-manager, dream2nix, nixos-hardware, uniclip, quickshell, dots-hyprland, dots-hyprland-source, ... }:
  let
    system = "aarch64-linux";
    lib = nixpkgs.lib;
    pkgs-stable = import inputs.nixpkgs-stable {
      inherit system;
      config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "python-2.7.18.7"
          "openssl-1.1.1w"
        ];
      };
    };
    pkgs-unstable = import inputs.nixpkgs-unstable {
      inherit system;
      config = {
        allowUnfree = true;
      };
      overlays = [
        (import ./overlays/jetbrains-toolbox.nix)
      ];
    };
    pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
      config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "vscode"
      ];
      config.allowUnsupportedSystem = true;
      overlays = [
        dots-hyprland.overlays.default
        (import ./overlays/debugpy.nix)
        (import ./overlays/materialyoucolor.nix)
        (import ./overlays/end-4-dots.nix)
        (import ./overlays/wofi-calc.nix)
      ];
    };
  in {
    nixosConfigurations = {
      nixberry = nixpkgs.lib.nixosSystem {
        #inherit system;
        specialArgs = {
          inherit pkgs;
          inherit pkgs-stable;
          inherit pkgs-unstable;
          quickshell = quickshell.packages.${system}.default;
        };
        system.packages = [ anyrun.packages.${system}.anyrun
                          ];
        
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          ./nixberry/boot.nix
          ./nixberry/graphics.nix
          ./nixberry/networking.nix
          ./nixberry/virtualisation.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { 
              inherit inputs;
              inherit pkgs-stable;
              inherit pkgs-unstable;
            };
            home-manager.users.demo = import ./home.nix;
          }
        ];
      };
    };
  };
}

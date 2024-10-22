# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, pkgs-stable, ... }:
{
  # Licences.
  nixpkgs.config = {
    allowUnfree = true;
  };  

  # Inscure packages allowed.
  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.7"
    "openssl-1.1.1w"
  ];

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Enable Flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Udev rules.
  hardware.uinput.enable = true;

  # Set your time zone.

  services.automatic-timezoned.enable = true;
  location.provider = "geoclue2";
  #time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the GDM Display Manager.
  services.displayManager = {
    defaultSession = "hyprland";
  };
  services.xserver.displayManager.gdm = {
      enable = true;
      wayland = true;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Enlightenment Desktop Environment.
  services.xserver.desktopManager.mate.enable = true;
  services.xserver.desktopManager.mate.enableWaylandSession = true;

  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;
    package = pkgs.hyprland;
    # Whether to enable Xwayland
    xwayland.enable = true;
  };

  programs.fish = {
    enable = true;
  };
  
  # Enable Location.
  services.geoclue2.enable = true;

  # Enable acpid
  services.acpid.enable = true;

  # Enable plymouth
  boot.plymouth.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.jack = {
    #jackd.enable = true;
    # support ALSA only programs via ALSA JACK PCM plugin
    alsa.enable = true;
    # support ALSA only programs via loopback device (supports programs like Steam)
    loopback = {
      enable = true;
      # buffering parameters for dmix device to work with ALSA only semi-professional sound programs
      #dmixConfig = ''
      #  period_size 2048
      #'';
    };
  };

  # Enable Fonts.
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    fontconfig
    lexend
    nerdfonts
    material-symbols
    bibata-cursors
  ];

  # Extra Groups
  users.groups.mlocate = {};
  users.groups.plocate = {};

  security.sudo.configFile = ''
    root   ALL=(ALL:ALL) SETENV: ALL
    %wheel ALL=(ALL:ALL) SETENV: ALL
    demo  ALL=(ALL:ALL) SETENV: ALL
  '';

  # Gnome Keyring
  services.gnome.gnome-keyring.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  services.keyd = {
    enable = true;
    keyboards.mac.settings = {
      main = {
        control = "layer(meta)";
        meta = "layer(control)";
        rightcontrol = "layer(meta)";
      };
      meta = {
        left =  "control-left";
        right = "control-right";
        space = "control-space";
      };
    };
    keyboards.mac.ids = [
      "*"
    ];
  };

  # Gestures.
  services.touchegg.enable = true;

  # Garbage Collection.
  nix.optimise.automatic = true;
 
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.demo = {
    isNormalUser = true;
    description = "Demo User";
    password = "demo";
    extraGroups = [ "libvirtd" "networkmanager" "wheel" "input" "uinput" "render" "video" "audio" ];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };

  # List packages installed in system profile. To search, run:
  # Enable Wayland for Electron.
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.MOZ_ENABLE_WAYLAND = "1";

  # $ nix search wget
  environment.systemPackages = 
  (with pkgs-stable; [
    # Editors.
    vim
    
    # Networking Tools.
    wget
    curl
    rsync
    nmap
    tmate

    # Audio.
    ladspaPlugins
    calf
    lsp-plugins
    alsa-utils

    # System Tools.
    glxinfo
    blueman
    networkmanagerapplet
    nix-index
    mlocate
    barrier
    openssl
    gnome.simple-scan
    btop
    thefuck

    # Shells.
    fish
    zsh
    bash

    # Development Tools.
    git
    sublime4
    sqlite

    # Session.
    polkit
    polkit_gnome
    dconf
    killall
    gnome.gnome-keyring
    evtest
    gnome.zenity
    linux-pam
    cliphist
    sudo

    # Wayland.
    xwayland
    ydotool
    fcitx5
    wlsunset
    wtype
    wl-clipboard
    xorg.xhost
    wev
    wf-recorder
    mkvtoolnix-cli
    vulkan-tools
    libva-utils
    wofi
    libqalculate
    xfce.thunar
    wayland-scanner
    
    # GTK
    gtk3
    gtk3.dev
    libappindicator-gtk3.dev
    libnotify.dev
    gtk4
    gtk4.dev
    gjs
    gjs.dev
    gtksourceview
    gtksourceview.dev
    xdg-desktop-portal-gtk

    # Not GTK.
    tk
  ])

  ++

  (with pkgs; [
    nil
    foot
    kitty
    pulseaudio
    xdg-desktop-portal-hyprland
    hyprpaper
    gnome.gdm
  ]);

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}

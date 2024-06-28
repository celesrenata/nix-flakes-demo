{ ... }:
{
  config = {
    # Networking.
    networking.hostName = "nixberry"; # Define your hostname.
    networking.networkmanager.enable = true;
    networking.networkmanager.wifi.backend = "iwd";
    networking.wireless.iwd = {
      enable = true;
      settings.General.EnableNetworkConfiguration = true;
    };

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable Bluetooth
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;
    hardware.enableAllFirmware = true;

    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 5900 53701 ];
      # allowedUDPPorts = [ 7236 5353 ];
      # allowedUDPPortRanges = [
      #   { from = 24800; to = 24810; }
      #   { from = 47998; to = 48000; }
      #   { from = 8000; to = 8010; }
      # ];
    };
  };
}

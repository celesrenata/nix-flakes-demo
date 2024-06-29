# NixOS in UTM with Host Ollama and Hyprland Clipboard Passthrough

## Installation
1. Install UTM from: https://mac.getutm.app
2. Download Arm64 image from https://nixos.org/download/#download-nixos
3. Settings > Input > Caputre input automatically when entering full screen
4. Settings > Display > Render Backend > ANGLE (OpenGL)
5. 
6. Create new VM:
   1. Virtualize
   2. Linux
   3. Attach ISO
   4. Provide 8GB+ of RAM
   5. 2+ Cores
   6. Enable Hardware OpenGL acceleration
   7. 64GB+ of space
   8. Open VM Settings (on last before clicking 'Save')
7. Edit VM Settings:
   1. Change Network Settings from 'Shared' to 'Bridged' mode.
   2. Add a new Network Controller
   3. Host Only
   4. Advanced Settings
   5. Guest Network **must** be: 192.168.128.0/24
   6. DHCP Start range **must** be: 192.168.128.1
   7. DCHP End range can be anything higher than 192.168.128.4 for safety.
   8. Save
8. Start the VM:
   1. ad-hoc install git: `nix-shell -p git`
   2. download the flakes! `git clone https://github.com/celesrenata/nix-flakes-demo`
   3. `cd nix-flakes-demo`
   4. setup the partitions for yourself without a fight `sudo ./setup.sh`
   5. add "compress=zstd" to btrfs options lines in `vim /mnt/etc/nixos/hardware-configuration.nix`
   6. install the system! `sudo nixos-install --root /mnt --flake /mnt/etc/nixos#nixberry`
   7. `reboot`
   8. Login with demo:demo
   9. System will reboot and configure itself
   10. Login again and enjoy!

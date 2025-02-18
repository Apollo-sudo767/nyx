{ config, pkgs, ... }:

{
  imports =
    [
      ../../modules/server.nix
      # ../../modules/containers.nix
      ./hardware-configuration.nix
    ];
   
  # Bootloader
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot"; # <- use the same mount point here
    };
    systemd-boot.enable = true;
    systemd-boot.extraFiles."efi/shell.efi" = "${pkgs.edk2-uefi-shell}/shell.efi";
  };

  networking.hostName = "aether"; #Define hostname here
  
  
  #Services
  services = {
    xserver = {
      enable = true;
      xkb = {
        variant = "";
        layout = "us";
      };
    };
    # excludePackages = [ pkgs.xterm ];
    libinput.enable = true;
    dbus.enable = true;
    tumbler.enable = true;
  };

  # Enable networking
  networking.networkmanager.enable = true;
  networking.defaultGateway = "192.168.1.254";

  system.stateVersion = "24.11";
}

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ../../modules/desktop.nix
      ../../modules/hyprland.nix
      ../../modules/i3.nix
      ../../modules/neovim

      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot"; # ← use the same mount point here.
    };
    systemd-boot.enable = true;
  };

  networking.hostName = "nyx"; # Define your hostname.
  
  # Services
  services = {
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      excludePackages = [ pkgs.xterm ];
      videoDrivers = ["nvidia"];
      libinput.enable = true;
      displayManager.gdm.enable = true;
    };
    dbus.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
  };
  
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.defaultGateway = "192.168.1.254";

  # for Nvidia GPU
  # Hardware
  hardware = {
    graphics = {
      enable = true;
      # driSupport = true;
      # driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        vulkan-loader
        vulkan-headers
        #  pkgsi686Linux.vulkan-loader
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
      # setLdLibraryPath = true;
    };
    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      forceFullCompositionPipeline = true;
      powerManagement.enable = true;
    };
  };

  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}

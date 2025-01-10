# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ../../modules/desktop.nix
      ../../modules/hyprland.nix
      # ../../modules/i3.nix
      # ../../modules/cosmic.nix # Not packaged for nixos yet
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Stylix
  stylix = {
    enable = true;
    image = pkgs.fetchurl {
      url = "https://live.staticflickr.com/65535/52211883799_9642668157_o_d.png";
      sha256 = "5bdc52f583da6dc14c26ac3f00d1e5ff45ae7a1da3820d5abf4076b512e18e76";
    };
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";

      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "Dejavu Sans";

      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "Dejavu Serif";
      };
      sizes = {
        applications = 10;
        desktop = 10;
        popups = 10;
        terminal = 12;
      };
    };
    opacity = {
      applications = 1.0;
      terminal = 0.8;
      desktop = 1.0;
      popups = 1.0;
    };
    polarity = "dark";
  };

  # Bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot"; # ← use the same mount point here.
    };
    systemd-boot.enable = true;
    systemd-boot.extraFiles."efi/shell.efi" = "${pkgs.edk2-uefi-shell}/shell.efi";
    systemd-boot.extraEntries = {
       # Chainload Windows bootloader via EDK2 Shell
      "windows.conf" =
        let
          # To determine the name of the windows boot drive, boot into edk2 first, then run
          # `map -c` to get drive aliases, and try out running `FS1:`, then `ls EFI` to check
          # which alias corresponds to which EFI partition.
          boot-drive = "FS1";
        in
        ''
          title Windows Bootloader
          efi /efi/shell.efi
          options -nointerrupt -nomap -noversion HD0b:EFI\Microsoft\Boot\Bootmgfw.efi
          sort-key y_windows
        '';
      # Make EDK2 Shell available as a boot option
      "edk2-uefi-shell.conf" = ''
        title EDK2 UEFI Shell
        efi /efi/shell.efi
        sort-key z_edk2
      '';
    };
  };

  networking.hostName = "nyx"; # Define your hostname.
  
  # Services
  services = {
    xserver = {
      enable = true;
      xkb = {
        variant = "";
        layout = "us";
      };
      excludePackages = [ pkgs.xterm ];
      videoDrivers = ["nvidia"];
      displayManager = {
        gdm.enable = true;
      };
    };
    libinput.enable = true;
    # desktopManager = {
    #   cosmic-greeter.enable = true;
    # };
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
      package = config.boot.kernelPackages.nvidiaPackages.beta;
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

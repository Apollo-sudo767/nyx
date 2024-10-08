# Do not modify this file! I hand wrote it
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = 
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = 
    { device = "/dev/disk/by-uuid/051ffbc0-75e3-42bf-8a35-2431144887b9";
      fsType = "ext4";
    };
  fileSystems."/boot" = 
    { device = "/dev/disk/by-uuid/578A-AD73";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  swapDevices = [ ];
  
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

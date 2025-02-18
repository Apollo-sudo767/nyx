{ pkgs, lib, inputs, ... }:

{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;

    servers = {
      modded-survival = {
        enable = true;
        package = pkgs.fabricServers.fabric-1_20_1;

        symlinks = let 
          modpack = pkgs.fetchPackwizModpack {
            url = "https://drive.google.com/file/d/1_wh-wSRD8_36-oXzygCsyvdYsyc-RNTQ/edit";
            packHash = "sha256-88c7baafd88effb5411f9f64db696a068680fec7e50e02eb00a37e03ebf83601";
          };
        in
        {
          "mods" = "${modpack}/mods";
        };
        };
      };
    };
}


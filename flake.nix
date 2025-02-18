{
  description = "Apollo's flake";
  
  # nixConfig here only affects flake itself
  nixConfig = {
    # substituters will be default when fetching packages
    # nix com   extra-substituter = [munity's cache server
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager";
    #  home-manager.inputs.nxpkgs.follows = "nixpkgs";
    
    # Stylix
    stylix.url = "github:danth/stylix";
    
    # Server/Nixos-Containers
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    # Add additional inputs if necessary
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs-unstable,
    nixpkgs-stable,
    home-manager,
    stylix,
    nix-minecraft,
    ...
  }: {
    nixosConfigurations = {
      nyx = let
        username = "apollo";
        specialArgs = {inherit username;};
      in
        nixpkgs-unstable.lib.nixosSystem {
          inherit specialArgs;
          system = "x86_64-linux";

          modules = [
            ./hosts/nyx
            ./users/${username}/nixos.nix
              {
                nix.settings = {
                  substituters = [ "https://cosmic.cachix.org/"];
                  trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
                };

              }
            stylix.nixosModules.stylix # Importing Stylix Module
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = inputs // specialArgs;
              home-manager.users.${username} = import ./users/${username}/home.nix;
            }
          ];
        };

        aether = let
          username = "hermes"; # another username for this machine
          specialArgs = {inherit username;};
        in
          nixpkgs-stable.lib.nixosSystem {
          inherit specialArgs;
          system = "x86_64-linux";
        
          modules = [
           ./hosts/aether
           ./users/${username}/nixos.nix

           nix-minecraft.nixosModules.nix-minecraft
           home-manager.nixosModules.home-manager
           {
             home-manager.useGlobalPkgs = true;
             home-manager.useUserPackages = true;
        
             home-manager.extraSpecialArgs = inputs // specialArgs;
             home-manager.users.${username} = import ./users/${username}/home.nix;
           }
         ];
        };
    };
  };
}

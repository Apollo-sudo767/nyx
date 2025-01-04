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
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    #  home-manager.inputs.nxpkgs.follows = "nixpkgs";
    
    # Stylix
    stylix.url = "github:danth/stylix";

    # Cosmic DE
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";

    # Add additional inputs if necessary
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    nixos-cosmic,
    stylix,
    ...
  }: {
    nixosConfigurations = {
      nyx = let
        username = "apollo";
        specialArgs = {inherit username;};
      in
        nixpkgs.lib.nixosSystem {
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
            nixos-cosmic.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = inputs // specialArgs;
              home-manager.users.${username} = import ./users/${username}/home.nix;
            }
          ];
        };

        #hermes = let
        #username = "apollo"; # another username for this machine
        #specialArgs = {inherit username;};
        #in
        #nixpkgs.lib.nixosSystem {
        # inherit specialArgs;
        # system = "x86_64-linux";
        #
        # modules = [
        #   ./hosts/hermes
        #   ./users/${username}/nixos.nix
        #   
        #   home-manager.nixosModules.home-manager
        #   {
        #     home-manager.useGlobalPkgs = true;
        #     home-manager.useUserPackages = true;
        #
        #     home-manager.extraSpecialArgs = inputs // specialArgs;
        #     home-manager.users.${username} = import ./users/${username}/home.nix;
        #   }
        # ];
        #};
    };
  };
}

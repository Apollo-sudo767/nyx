{
  description = "Apollo's flake";
  
  # nixConfig here only affects flake itself
  nixConfig = {
    # substituters will be default when fetching packages
    # nux com   extra-substituter = [munity's cache server
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nxpkgs.follows = "nixpkgs";

    # Add additional inputs if necessary
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
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

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = inputs // specialArgs;
              home-manager.users.${username} = import ./users/${username}/home.nix;
            }
          ];
        };

#      aether = let
#        username = "hermes"; # another username for this machine
#        specialArgs = {inherit username;};
#      in
#        nixpkgs.lib.nixosSystem {
#          inherit specialArgs;
#          system = "x86_64-linux";
#
#          modules = [
#            ./hosts/aether
#            ./users/${username}/nixos.nix
#
#            home-manager.nixosModules.home-manager
#            {
#              home-manager.useGlobalPkgs = true;
#              home-manager.useUserPackages = true;
#
#              home-manager.extraSpecialArgs = inputs // specialArgs;
#              home-manager.users.${username} = import ./users/${username}/home.nix;
#            }
#          ];
#        };
    };
  };
}

{ pkgs, nixvim, ... }: {
  home.packages = with pkgs; [
    gnumake
    catppuccin-cursors.mochaDark
    wl-clipboard

    (nixvim.legacyPackages."${pkgs.stdenv.hostPlatform.system}".makeNixvimWithModule {
      inherit pkgs;
      module = import ./nixvim;
    })
  ];
}

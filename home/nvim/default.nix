{ pkgs, nixvim, ... }: {
  home.packages = with pkgs; [
    gnumake
    catpuccin-cursors.mochadark
    wl-clipboard

    (nixvim.legacyPackages."${pkgs.stdenv.hostPlatform.system}".makeNixvimWithModule {
      inherit pkgs;
      module = import ./nixvim;
    })
  ];
}

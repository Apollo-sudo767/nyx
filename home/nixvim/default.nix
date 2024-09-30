{ pkgs, nixvim, ... }: {
  home.packages = with pkgs; [
    gnumake
    wl-clipboard

    (nixvim.legacyPackages."${pkgs.stdenv.hostPlatform.system}".makeNixvimWithModule {
      inherit pkgs;
      module = import ./nvim;
    })
  ];
}

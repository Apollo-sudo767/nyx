{
  pkgs,
  config,
  ...
}: {
    # wallpaper, binary file
  home.file.".config/nvim/init.lua".source = ./init.lua;


}

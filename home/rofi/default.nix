{
  pkgs,
  config,
  ...
}: {
    home.file.".config/rofi" = {
    source = ./configs;
    # copy the scripts directory recursively
    recursive = true;
  };
    home.file.".config/rofi/themes/marble.rasi".source = ./configs/marble.rasi;
 }


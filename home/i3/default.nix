{
  pkgs,
  config,
  ...
}: {
   # Model from hyprland stuff
  home.file.".config/polybar/polybar.ini".source = ./polybar/polybar.ini;
  home.file.".config/i3/config".source = ./i3.conf;
  home.file.".config/picom/picom.conf".source =./picom.conf;
  home.file.".config/i3/scripts" = {
    source = ./scripts;
    # copy the scripts directory recursively
      recursive = true;
      executable = true; # make all scripts executable
  };
  
  
  } 

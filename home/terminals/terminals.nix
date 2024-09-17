{ pkgs, ... }:

# Example configuration for kitty in home.nix
{
  programs.kitty = {
    enable = true;
    
    extraConfig = "
      background_opacity 0.8
    ";   
  };
}

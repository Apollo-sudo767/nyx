{ pkgs, ... }:

{
  imports = [
    ../../home/core.nix
    ../../home/nixvim
  ];

  programs.git = {
    userName = "Apollo-sudo767";
    userEmail = "blured767@gmail.com";
  };
}

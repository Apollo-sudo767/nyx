{pkgs, ...}: {
  ##################################################################################################
  #                                                                                                #
  #                                 Home Configuration of Apollo                                   #
  #                                                                                                #
  ##################################################################################################

  imports = [
    ../../home/core.nix
    
    # All the other stuff in the home folder
   
    ../../home/hypr
    ../../home/programs
    ../../home/rofi
    ../../home/terminals
  ];
   
}

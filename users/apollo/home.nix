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
 
  programs.git = {
    userName = "Apollo-sudo767";
    userEmail = "fireshifter767@gmail.com";
  };
}

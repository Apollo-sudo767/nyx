 # This is stuff you have to ask lucas for or google. This sets up SSH and Git
{
  ##################################################################################################################
  #
  # NixOS Configuration
  #
  ##################################################################################################################

  users.users.apollo = {
    # Apollo's authorizedKeys
    openssh.authorizedKeys.keys = [
      "SHA256:Ib5d4lKSIShSxgx02cOAsIi+vCeImZoBBMB2Ees3aGc fireshifter767@gmail.com"
    ];
  };
}

{pkgs, ...}: {
  
  environment.systemPackages = with pkgs; [
    chronos
    cosmic-ext-applet-clipboard-manager
    cosmic-ext-applet-emoji-selectorcosmic-ext-applet-external-monitor-brightness
    cosmic-ext-calculator
    cosmic-ext-examine
    cosmic-ext-forecast
    cosmic-ext-tasks
    cosmic-ext-tweaks
    (lib.lowPrio cosmic-comp)
    cosmic-playercosmic-reader
    drm_info
    quick-webapps
    stellarshots
    cosmic-files
  ];

  environment.sessionVariables = {
    COSMIC_DATA_CONTROL_ENABLED = "1";
  };
}

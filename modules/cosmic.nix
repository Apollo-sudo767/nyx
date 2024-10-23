{pkgs, ...}: {
  
  environment.systemPackages = with pkgs; [
    #  chronos # Pomodoro Timer for Cosmic (Do not know what this is)
    cosmic-bg
    cosmic-osd
    cosmic-term
    cosmic-edit
    cosmic-comp
    cosmic-tasks
    cosmic-store
    cosmic-randr
    cosmic-panel
    cosmic-icons
    cosmic-files
    cosmic-session
    cosmic-applets
    cosmic-settings
    cosmic-launcher
    cosmic-protocols
    cosmic-screenshot
    cosmic-applibrary
    cosmic-notifications
    cosmic-settings-daemon
    xdg-desktop-portal-cosmic


  ];

  environment.sessionVariables = {
    COSMIC_DATA_CONTROL_ENABLED = "1";
  };
}

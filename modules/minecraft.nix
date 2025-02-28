{ config, pkgs, lib, ... }:
{
  systemd.services.mc-backup = {
    description = "Minecraft World Backup Service";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/var/minecraft/scripts/mcbackup.sh"; 
      User = "minecraft";  # Change this if needed
    };
  };

  systemd.timers.mc-backup = {
    description = "Minecraft Backup Timer";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "00:00,12:00";  # Runs once per day
      Persistent = true;
    };
  };
}

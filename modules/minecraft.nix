{ config, pkgs, lib, ... }:
let
  backupScript = pkgs.writeShellScriptBin "mc-backup" ''
    #!/bin/bash
    source_dir="/var/minecraft/world"
    backup_dir="/var/minecraft/backups"

    # Create a timestamp
    timestamp=$(date +"%Y%m%d%H%M%S")
    backup_destination="$backup_dir/backup-$timestamp"

    # Ensure the backup directory exists
    mkdir -p "$backup_dir"

    # Copy the world data
    cp -R "$source_dir" "$backup_destination"

    echo "Backup created at: $backup_destination"

    # Remove old backups, keeping only the 5 most recent ones
    backups=($(ls -d "$backup_dir"/backup-* 2>/dev/null | sort -r))
    if [[ "''${#backups[@]}" -gt 5 ]]; then
      to_delete=("''${backups[@]:5}")
      for old_backup in "''${to_delete[@]}"; do
        rm -rf "$old_backup"
        echo "Deleted old backup: $old_backup"
      done
    fi
  '';
  in
{
  systemd.services.mc-backup = {
    description = "Minecraft World Backup Service";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${backupScript}/bin/mc-backup";
      User = "minecraft";  # Change this if needed
    };
  };

  systemd.timers.mc-backup = {
    description = "Minecraft Backup Timer";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";  # Runs once per day
      Persistent = true;
    };
  };
}

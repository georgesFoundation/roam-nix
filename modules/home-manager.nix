{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.roam-activity;
  shared = import ./roam-activity-options.nix { inherit lib pkgs; };
in
{
  options.services.roam-activity = shared.options;

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    systemd.user.services.roam-activity = {
      Unit = {
        Description = "Set a custom Roam activity";
        After = [ "network-online.target" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${lib.getExe cfg.package} set";
        # Quote each assignment so values with spaces or quotes survive systemd parsing.
        Environment = lib.mapAttrsToList (name: value: ''"${name}=${lib.escape [ "\\" "\"" ] value}"'') (
          shared.environment cfg
        );
        Restart = "on-failure";
        RestartSec = "30s";
      };
    };

    systemd.user.timers.roam-activity = {
      Unit.Description = "Refresh the custom Roam activity";
      Timer = {
        OnStartupSec = "30s";
        OnUnitActiveSec = cfg.interval;
      };
      Install.WantedBy = [ "timers.target" ];
    };
  };
}

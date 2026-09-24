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
    environment.systemPackages = [ cfg.package ];

    # A user unit: it runs for every user with a session, so tokenFile should
    # point somewhere only that user can read (e.g. under their home).
    systemd.user.services.roam-activity = {
      description = "Set a custom Roam activity";
      after = [ "network-online.target" ];
      environment = shared.environment cfg;
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${lib.getExe cfg.package} set";
        Restart = "on-failure";
        RestartSec = "30s";
      };
    };

    systemd.user.timers.roam-activity = {
      description = "Refresh the custom Roam activity";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnStartupSec = "30s";
        OnUnitActiveSec = cfg.interval;
      };
    };
  };
}

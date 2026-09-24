# Options and environment shared by the NixOS and Home Manager modules.
{ lib, pkgs }:

let
  inherit (lib) mkEnableOption mkOption types;
in
{
  options = {
    enable = mkEnableOption "a systemd user timer that keeps a custom Roam activity set";

    package = mkOption {
      type = types.package;
      default = pkgs.callPackage ../pkgs/roam-activity.nix { };
      defaultText = lib.literalExpression "pkgs.callPackage ./pkgs/roam-activity.nix { }";
      description = "The roam-activity package to use.";
    };

    tokenFile = mkOption {
      type = types.str;
      example = "/run/secrets/roam-token";
      description = ''
        Path to a file containing a Roam personal access token (create one in
        Roam settings; any scope works). Read at runtime, so it stays out of
        the Nix store — use sops-nix, agenix or a plain file in your home.
      '';
    };

    userId = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = ''
        Your Roam user id. When null it is looked up via `token.info` on
        every run. Run `roam-activity info` to find it.
      '';
    };

    externalId = mkOption {
      type = types.str;
      default = "nixos:ftw";
      description = "Stable identifier for the activity; reusing it updates the existing one.";
    };

    emoji = mkOption {
      type = types.str;
      default = "❄️";
      description = "Emoji shown next to the activity.";
    };

    title = mkOption {
      type = types.str;
      default = "NixOS";
      description = "Activity title.";
    };

    subtitle = mkOption {
      type = types.str;
      default = "ftw";
      description = "Activity subtitle.";
    };

    color = mkOption {
      type = types.str;
      default = "purple";
      description = "Activity color, as accepted by the Roam API.";
    };

    ttl = mkOption {
      type = types.ints.between 1 3600;
      default = 3600;
      description = "Activity lifetime in seconds. Roam clamps this to one hour.";
    };

    interval = mkOption {
      type = types.str;
      default = "30min";
      description = ''
        How often to refresh the activity, as a systemd time span. Keep it
        below `ttl` so the activity never expires while you are logged in.
      '';
    };
  };

  # Values are %-escaped so systemd does not expand them as unit specifiers.
  environment =
    cfg:
    lib.mapAttrs (_: lib.replaceStrings [ "%" ] [ "%%" ]) (
      {
        ROAM_TOKEN_FILE = cfg.tokenFile;
        ROAM_EXTERNAL_ID = cfg.externalId;
        ROAM_EMOJI = cfg.emoji;
        ROAM_TITLE = cfg.title;
        ROAM_SUBTITLE = cfg.subtitle;
        ROAM_COLOR = cfg.color;
        ROAM_TTL = toString cfg.ttl;
      }
      // lib.optionalAttrs (cfg.userId != null) { ROAM_USER_ID = cfg.userId; }
    );
}

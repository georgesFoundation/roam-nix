# Example home-manager configuration using Roam package

{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Option 1: If using flakes
    (import (fetchTarball "https://github.com/georgesFoundation/Roam-nix/archive/main.tar.gz") {
      inherit pkgs;
    }).roam

    # Option 2: If you have the package locally
    # (import /path/to/Roam-nix { inherit pkgs; }).roam
  ];

  # Optional: Add desktop file to user applications
  home.file.".local/share/applications/roam.desktop".source =
    let
      roam =
        (import (fetchTarball "https://github.com/georgesFoundation/Roam-nix/archive/main.tar.gz") {
          inherit pkgs;
        }).roam;
    in
    "${roam}/share/applications/roam.desktop";
}

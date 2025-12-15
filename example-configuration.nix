# Example NixOS configuration using Roam package

{ config, pkgs, ... }:

{
  # Add Roam to system packages
  environment.systemPackages = with pkgs; [
    # Option 1: If using flakes
    (import (fetchTarball "https://github.com/georgesFoundation/Roam-nix/archive/main.tar.gz") {
      inherit pkgs;
    }).roam

    # Option 2: If you have the package locally
    # (import /path/to/Roam-nix { inherit pkgs; }).roam
  ];

  # Enable sound for Roam (required for audio features)
  hardware.pulseaudio.enable = true;
  # OR
  services.pipewire.pulse.enable = true;

  # Enable X11/Wayland for GUI applications
  services.xserver.enable = true;

  # Optional: Enable keyring for password storage
  services.gnome.gnome-keyring.enable = true;

  # Optional: Add desktop entry to application menu
  environment.systemPackages = with pkgs; [
    # This ensures desktop files are recognized
    desktop-file-utils
  ];
}

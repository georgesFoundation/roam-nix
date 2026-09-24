{
  pkgs ? import <nixpkgs> { },
}:

{
  roam = pkgs.callPackage ./default.nix { };
  roam-activity = pkgs.callPackage ./pkgs/roam-activity.nix { };
}

{
  pkgs ? import <nixpkgs> { },
}:

{
  roam = pkgs.callPackage ./default.nix { };
}

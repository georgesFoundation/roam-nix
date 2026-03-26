{
  description = "Roam Nix Package";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = {
          roam = pkgs.callPackage ./default.nix { };
          default = self.packages.${system}.roam;
        };

        apps = {
          roam = {
            type = "app";
            program = "${self.packages.${system}.roam}/bin/roam";
          };
          default = self.apps.${system}.roam;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            curl
            just
            nixpkgs-fmt
          ];
        };
      }
    );
}

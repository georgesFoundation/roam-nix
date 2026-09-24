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
    {
      nixosModules = {
        roam-activity = ./modules/nixos.nix;
        default = self.nixosModules.roam-activity;
      };
      homeManagerModules = {
        roam-activity = ./modules/home-manager.nix;
        default = self.homeManagerModules.roam-activity;
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = {
          roam = pkgs.callPackage ./default.nix { };
          roam-activity = pkgs.callPackage ./pkgs/roam-activity.nix { };
          default = self.packages.${system}.roam;
        };

        apps = {
          roam = {
            type = "app";
            program = "${self.packages.${system}.roam}/bin/roam";
          };
          roam-activity = {
            type = "app";
            program = "${self.packages.${system}.roam-activity}/bin/roam-activity";
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

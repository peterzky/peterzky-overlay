{
  description = "Peter's personal overlay";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      overlay = import ./overlay.nix;
    in
      flake-utils.lib.eachDefaultSystem (
        system:
          let
            pkgs = import nixpkgs { inherit system; };
            pkgs_full = import nixpkgs {
              inherit system;
              overlays = [ overlay ];
              config.allowUnfree = true;
            };

          in
            rec {
              packages = flake-utils.lib.flattenTree pkgs_full.peterPkgs;
            }
      ) // {
        nixosModules = import ./modules;
        inherit overlay;
      };
}

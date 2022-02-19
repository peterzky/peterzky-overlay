{
  description = "Peter's personal overlay";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    # nixpkgs.url = "github:nixos/nixpkgs/master";
    nixpkgs.url = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ (import ./default.nix) ];
            config.allowUnfree = true;
          };
        in
        rec
        {
          packages = pkgs;
          templates = with pkgs;
            lib.genAttrs (lib.attrNames (builtins.readDir ./templates))
              (name: { path = ./templates + "/${name}"; description = ""; });

          nixosModules = import ./modules;

        }
      ) // {
      overlay = import ./default.nix;
    };
}

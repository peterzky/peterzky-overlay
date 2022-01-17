{
  description = "Peter's personal overlay";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixpkgs-unstable/nixexprs.tar.xz";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      overlay = import ./overlay.nix;
    in
    flake-utils.lib.eachDefaultSystem
      (
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
      templates = with nixpkgs;
        lib.genAttrs (lib.attrNames (builtins.readDir ./templates))
          (name: { path = ./templates + "/${name}"; description = ""; });

      nixosModules = import ./modules;

      inherit overlay;
    };
}

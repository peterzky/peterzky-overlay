{
  description = ''Meson C Flake Template
  export compile_commands.json
  nix develop
  meson setup builddir
  ln -s builddir/compile_commands.json .'';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      rec {
        packages = {
          meson_c = pkgs.callPackage ./default.nix { };
        };
        defaultPackage = packages.meson_c;

        devShell = pkgs.mkShell {
          name = "meson_c";
          inputsFrom = [ packages.meson_c ];
          buildInputs = with pkgs; [ clang-tools ];
          shellHook = ''
            update () {
              if [[ -d builddir ]]; then
                rm -rf builddir
              fi
              meson builddir
              ln -sf $PWD/builddir/compile_commands.json .
            }
          '';

        };
      }

    );

}

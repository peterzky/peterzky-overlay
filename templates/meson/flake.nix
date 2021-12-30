{
  description = ''Meson Cpp Flake Template
  export compile_commands.json
  nix develop
  meson setup builddir
  ln -s builddir/compile_commands.json .'';

  inputs = {
    nixpkgs.url = "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixpkgs-unstable/nixexprs.tar.xz";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      rec {
        packages = {
          hello = pkgs.callPackage ./default.nix { };
        };
        defaultPackage = packages.hello;
      }

    );

}

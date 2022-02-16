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
        # override packages in overlay
        overlay = final: prev: { };
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [ overlay ];
        };
      in
      rec {
        packages = {
          example_cpp_meson = pkgs.callPackage ./default.nix { };
        };
        defaultPackage = packages.example_cpp_meson;

        devShell = pkgs.mkShell {
          name = "example_cpp_meson";
          inputsFrom = [ packages.example_cpp_meson ];
        };

      }

    );

}

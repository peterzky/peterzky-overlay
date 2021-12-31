{
  description = "nix flake pyqt";

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
          # pyqt_app = pkgs.callPackage ./default.nix { };
          pyqt_app = pkgs.hello;
        };
        defaultPackage = packages.pyqt_app;

        devShell = pkgs.callPackage ./shell.nix { };
      }

    );

}

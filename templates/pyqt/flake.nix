{
  description = "nix flake pyqt";

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.hello;

    devShell.x86_64-linux =
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        python-deps = pkgs.python3.withPackages (ps: with ps;
        [
          pyside2
          python-lsp-server

        ]);
        qt-deps = pkgs.qt5.env "qt5" (with pkgs.qt5; [ qtwayland qttools ]);
      in
      pkgs.mkShell {
        name = "qt-playground";
        buildInputs = [
          python-deps
          qt-deps
        ];
      };

  };
}

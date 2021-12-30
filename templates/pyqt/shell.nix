{ mkShell, python3, qt5 }:
let
  python-deps = python3.withPackages (ps: with ps;
    [
      pyside2
      python-lsp-server
    ]);
  qt-deps = qt5.env "qt5" (with qt5; [ qtwayland qttools ]);
in
mkShell {
  name = "qt-playround";
  buildInputs = [
    python-deps
    qt-deps
  ];
}

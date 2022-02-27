final: prev:
let
  myOverrides = python-final: python-prev:
    with prev.python3.pkgs;
    rec {
      fuo = callPackage ../pkgs/python/feeluown/base.nix {
        mpv = prev.mpv;
        wrapQtAppsHook = prev.qt5.wrapQtAppsHook;
        extensions = [ fuo-netease fuo-local fuo-qqmusic ];
      };

      fuo-netease = callPackage ../pkgs/python/feeluown/netease.nix { };

      fuo-local = callPackage ../pkgs/python/feeluown/local.nix { };

      fuo-qqmusic = callPackage ../pkgs/python/feeluown/qqmusic.nix { };

    };

in
rec {
  python3 = prev.python3.override {
    self = python3;
    packageOverrides = prev.lib.composeManyExtensions
      [ myOverrides ];
  };

  feeluown = python3.pkgs.toPythonApplication python3.pkgs.fuo;
}

final: prev:
let
  myOverrides = python-final: python-prev: rec {

    _callPackage = prev.lib.callPackageWith (python-final // {
      inherit (prev) fetchFromGitHub lib;
    });

    i3-wk-switch = _callPackage ../pkgs/python/i3-wk-switch { };

    i3-quickterm = _callPackage ../pkgs/python/i3-quickterm { };

    fuo = _callPackage ../pkgs/python/feeluown/base.nix {
      mpv = prev.mpv;
      wrapQtAppsHook = prev.qt5.wrapQtAppsHook;
      extensions = [ fuo-netease fuo-local ];
    };

    notify-send-py = _callPackage ../pkgs/python/notify-send { };

    fuo-netease = _callPackage ../pkgs/python/feeluown/netease.nix { };

    fuo-local = _callPackage ../pkgs/python/feeluown/local.nix { };

  };

in
rec {
  python3 = prev.python3.override {
    packageOverrides = prev.lib.composeManyExtensions
      [ myOverrides ];
  };

  feeluown = python3.pkgs.fuo;
}

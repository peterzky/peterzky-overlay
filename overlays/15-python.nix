final: prev:
let
  myOverrides = python-final: python-prev: {
    i3-wk-switch = prev.callPackage ../pkgs/python/i3-wk-switch {
      buildPythonPackage = python-prev.buildPythonPackage;
      i3ipc = python-prev.i3ipc;
    };
    i3-quickterm = prev.callPackage ../pkgs/python/i3-quickterm {
      buildPythonPackage = python-prev.buildPythonPackage;
      i3ipc = python-prev.i3ipc;
    };

  };
  # for python3.8
  returnsOverrides = import ../pkgs/python/pip2nix/returns.nix {
    fetchurl = prev.fetchurl;
    pkgs = null;
    fetchgit = null;
    fetchhg = null;
  };
in
rec {
  python3 = prev.python3.override {
    packageOverrides = prev.lib.composeManyExtensions
      [ myOverrides returnsOverrides ];
  };
}

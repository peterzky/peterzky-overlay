final: prev:
let
  packageOverrides = python-final: python-prev: {
    i3-wk-switch = prev.callPackage ../pkgs/python/i3-wk-switch {
      buildPythonPackage = python-prev.buildPythonPackage;
      i3ipc = python-prev.i3ipc;
    };
    i3-quickterm = prev.callPackage ../pkgs/python/i3-quickterm {
      buildPythonPackage = python-prev.buildPythonPackage;
      i3ipc = python-prev.i3ipc;
    };
  };
in
rec {
  python3 = prev.python3.override {
    inherit packageOverrides;
  };
}

self: super:
let
  packageOverrides = python-self: python-super: {
    # pypinyin = python-super.callPackage ../packages/python/pypinyin { };

    # pydbus = python-super.callPackage ../packages/python/pydbus { };

    # pillow-simd = python-super.callPackage ../packages/python/pillow-simd { };

    # pyqt5-stubs = python-super.callPackage ../packages/python/pyqt5-stubs { };

    # service-factory =
    #   python-super.callPackage ../packages/python/service-factory { };

    matplotlib = python-super.matplotlib.override {
      # enableGtk3 = true;
      enableTk = true;
      # enableQt = true;
    };

    i3-wk-switch = super.callPackage ../packages/python/i3-wk-switch {
      buildPythonPackage = python-super.buildPythonPackage;
      i3ipc = python-super.i3ipc;
    };

    # i3ipc = python-super.callPackage ../packages/python/i3ipc { };

    mvnc = python-super.toPythonModule
      (super.ncsdk.override { pythonPackages = python-super.pythonPackages; });

  };

in {
  python3 = super.python3.override { inherit packageOverrides; };
  python36 = super.python36.override { inherit packageOverrides; };
}

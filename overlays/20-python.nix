self: super:
let
  packageOverrides = python-self: python-super: {
    pypinyin = python-super.callPackage ../packages/python/pypinyin { };

    pydbus = python-super.callPackage ../packages/python/pydbus { };

    pillow-simd = python-super.callPackage ../packages/python/pillow-simd { };

    pyqt5-stubs = python-super.callPackage ../packages/python/pyqt5-stubs { };

    service-factory =
      python-super.callPackage ../packages/python/service-factory { };

    matplotlib = python-super.matplotlib.override {
      # enableGtk3 = true;
      enableTk = true;
      # enableQt = true;
    };

  };
  packageOverrides37 = python-self: python-super: {
    i3-wk-switch = python-super.callPackage ../packages/python/i3-wk-switch { };

    i3ipc = python-super.callPackage ../packages/python/i3ipc { };
  };
in {
  python3 = super.python3.override { inherit packageOverrides; };
  python36 = super.python36.override { inherit packageOverrides; };
  python37 = super.python37.override { packageOverrides = packageOverrides37; };
}

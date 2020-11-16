self: super:

{
  libqcef = super.callPackage ../packages/libqcef.nix { };

  # fcitx5 dependencies
  xcb-imdkit = super.callPackage ../packages/fcitx5/xcb-imdkit.nix { };

  cldr-emoji-annotation =
    super.callPackage ../packages/fcitx5/cldr-emoji-annotation.nix { };

  fmt-combined = super.callPackage ../packages/fcitx5/fmt.nix { };

  fcitx5 = super.callPackage ../packages/fcitx5/fcitx5.nix { };

  opencv3 = super.opencv3.override {
    enableGtk3 = true;
    enableFfmpeg = true;
    enableUnfree = true;
  };

}

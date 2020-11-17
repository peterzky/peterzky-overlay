self: super: {

  # fcitx5 = super.callPackage ../packages/fcitx5/fcitx5.nix { };

  # libime = super.callPackage ../packages/fcitx5/libime.nix { };

  # fcitx5-qt = super.libsForQt5.callPackage ../packages/fcitx5/fcitx5-qt.nix { };

  # fcitx5-rime = super.callPackage ../packages/fcitx5/fcitx5-rime.nix { };

  # fcitx5-kcm =
  #   super.libsForQt5.callPackage ../packages/fcitx5/fcitx5-kcm.nix { };

  # fcitx5-chinese-addons =
  #   super.callPackage ../packages/fcitx5/fcitx5-chinese-addons.nix { };

  # fcitx5-with-plugins = super.callPackage ../packages/fcitx5/wrapper.nix { };

  # wofi dmenu replacement for wayland
  wofi = super.callPackage ../packages/wofi.nix { };

  wofi-bluetooth = super.callPackage ../packages/wofi-bluetooth { };

  my-tts = super.callPackage ../packages/go/tts { };

  i3-wk-switch = super.python37Packages.i3-wk-switch;

  my-timer = super.callPackage ../packages/go/timer { };

  v2ray = super.callPackage ../packages/go/v2ray { };

  gfw-white-list = super.callPackage ../packages/gfw-white-list.nix { };

  san-francisco-font = super.callPackage ../packages/san-francisco-font.nix { };

  my-sdcv-dict = super.callPackage ../packages/sdcv-dict.nix { };

  thinkpad_x1_rotation = super.callPackage ../packages/thinkpad_x1_rotation { };

  ueberzug = super.callPackage ../packages/python/ueberzug { };

  ranger-sixel = super.callPackage ../packages/ranger-sixel.nix { };

  my-latex = super.texlive.combine {
    inherit (super.texlive)
      scheme-small collection-langchinese environ trimspaces wrapfig capt-of
      minted fvextra ifplatform xstring framed fontspec;
  };

  input-fonts = super.callPackage ../packages/input-font { };

  dunst = super.dunst.override { dunstify = true; };

  # ibus enable wayland support
  ibus = super.ibus.override { withWayland = true; };

  dragon-drop = super.dragon-drop.overrideAttrs (oldAttrs: rec {
    src = super.fetchgit {
      url = "https://github.com/mwh/dragon.git";
      rev = "6d21f90e600bf5fd61b5a06cd09bb61b3f54ecbf";
      sha256 = "1p5ixjdgb7vsnh7xq0vmbixx23h6l5332ip8hck8g5rd2rv11zhq";
    };
  });

  ffmpegthumbnailer = super.callPackage ../packages/ffmpegthumbnailer.nix { };

  # feh enable auto reload
  feh = super.feh.overrideAttrs
    (oldAttrs: rec { makeFlags = oldAttrs.makeFlags ++ [ "inotify=1" ]; });

  # Suckless Tools
  st = super.st.overrideAttrs (oldAttrs: rec {
    src = super.fetchgit {
      url = "https://github.com/peterzky/st.git";
      rev = "ea6d1e9676c72c15fc664551dcc257b74b189f22";
      sha256 = "1g6pxnzkf5c5mlvjax5zbnnf7piq28ar6ywfdcf7k5w8sq1m0vx7";
      # date = 2019-07-09T17:53:15+08:00;
    };
  });


}

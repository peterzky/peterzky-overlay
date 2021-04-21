self: super: {
  ncsdk-fw = super.callPackage ../packages/ncsdk/ncsdk-fw.nix { };

  ncsdk = super.callPackage ../packages/ncsdk/ncsdk.nix {
    ncsdk-fw = self.ncsdk-fw;
    pythonPackages = super.python3Packages;
  };

  sws = super.callPackage ../packages/shellscript/sws { };

  interception-tools-plugins = super.interception-tools-plugins // {
    space2meta = super.callPackage ../packages/space2meta { };
  };

  foot-git = super.callPackage ../packages/foot { };

  wlroots-river = super.callPackage ../packages/wlroots { };

  zig-git = super.callPackage ../packages/zig-git {
    llvmPackages = super.llvmPackages_11;
  };

  river = super.callPackage ../packages/river {
    zig = self.zig-git;
    wlroots = self.wlroots-river;
  };

  wofi = super.callPackage ../packages/wofi.nix { };

  wofi-bluetooth = super.callPackage ../packages/wofi-bluetooth { };

  my-tts = super.callPackage ../packages/go/tts { };

  i3-wk-switch = super.python3Packages.i3-wk-switch;

  my-timer = super.callPackage ../packages/go/timer { };

  v2ray = super.callPackage ../packages/go/v2ray { };

  gfw-white-list = super.callPackage ../packages/gfw-white-list { };

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

  # ibus enable wayland support
  ibus = super.ibus.override { withWayland = true; };

  dragon-drop = super.dragon-drop.overrideAttrs (oldAttrs: rec {
    src = super.fetchgit {
      url = "https://github.com/mwh/dragon.git";
      rev = "6d21f90e600bf5fd61b5a06cd09bb61b3f54ecbf";
      sha256 = "1p5ixjdgb7vsnh7xq0vmbixx23h6l5332ip8hck8g5rd2rv11zhq";
    };
  });

  wayst-git = super.wayst.overrideAttrs (oldAttrs: rec {
    src = super.fetchFromGitHub {
      owner = "91861";
      repo = "wayst";
      rev = "e72ca78ef72c7b1e92473a98d435a3c85d7eab98";
      # date = 2021-04-05T19:50:37+02:00;
      sha256 = "112jajl34xl4i82bh9zal47jcqjmml6k6a0f985gz4v9ym4iaw2i";
    };                           #
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

final: prev:
{
  autotiling-git = prev.autotiling.overrideAttrs (
    oldAttrs: rec {
      name = "autotiling-${version}";
      version = "git";
      src = prev.fetchFromGitHub {
        owner = "nwg-piotr";
        repo = "autotiling";
        rev = "0451e5b615d8c23c760047cc01e8358af7acdddf";
        # date = 2021-03-17T01:08:26+01:00;
        sha256 = "0ih8yd1gankjxn88gd88vxs6f1cniyi04z25jz4nsgqi9snz65v4";
      };
    }
  );

  i3-wk-switch = final.python3Packages.i3-wk-switch;
  # libs
  libqcef = prev.callPackage ../pkgs/libqcef.nix {};

  # files
  chnroute-ipset =
    prev.writeText "chnrout.ipset" (builtins.readFile ./files/chnroute.ipset);

  # packages
  wayst-git = prev.wayst.overrideAttrs (
    oldAttrs: rec {
      src = prev.fetchFromGitHub {
        owner = "91861";
        repo = "wayst";
        rev = "e72ca78ef72c7b1e92473a98d435a3c85d7eab98";
        # date = 2021-04-05T19:50:37+02:00;
        sha256 = "112jajl34xl4i82bh9zal47jcqjmml6k6a0f985gz4v9ym4iaw2i";
      };
    }
  );

  nvd = prev.callPackage ../pkgs/nvd {};

  sws = prev.callPackage ../pkgs/shell-script/sws {};

  interception-tools-plugins = prev.interception-tools-plugins // {
    space2meta = prev.callPackage ../pkgs/space2meta {};
  };

  foot-git = prev.callPackage ../pkgs/foot {};

  wlroots-river = prev.callPackage ../pkgs/wlroots {};

  zig-git = prev.callPackage ../pkgs/zig-git {
    llvmPackages = prev.llvmPackages_11;
  };

  river = prev.callPackage ../pkgs/river {
    zig = final.zig-git;
    wlroots = final.wlroots-river;
  };

  v2ray = prev.callPackage ../pkgs/go/v2ray {};

  gfw-white-list = prev.callPackage ../pkgs/gfw-white-list {};

  san-francisco-font = prev.callPackage ../pkgs/san-francisco-font.nix {};

  sdcv-dict = prev.callPackage ../pkgs/sdcv-dict.nix {};
}

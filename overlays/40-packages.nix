final: prev:
{

  i3-wk-switch = final.python3Packages.i3-wk-switch;

  i3-quickterm = final.python3Packages.i3-quickterm;

  # files
  chnroute-ipset =
    prev.writeText "chnrout.ipset" (builtins.readFile ../files/chnroute.ipset);

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

  interception-tools-plugins = prev.interception-tools-plugins // {
    space2meta = prev.callPackage ../pkgs/space2meta {};
  };

  foot-git = prev.callPackage ../pkgs/foot {};

  v2ray = prev.callPackage ../pkgs/go/v2ray {};

  gfw-white-list = prev.callPackage ../pkgs/gfw-white-list {};

  san-francisco-font = prev.callPackage ../pkgs/san-francisco-font.nix {};

  sdcv-dict = prev.callPackage ../pkgs/sdcv-dict.nix {};

  # Suckless Tools
  st = prev.st.overrideAttrs (
    oldAttrs: rec {
      src = prev.fetchgit {
        url = "https://github.com/peterzky/st.git";
        rev = "ea6d1e9676c72c15fc664551dcc257b74b189f22";
        sha256 = "1g6pxnzkf5c5mlvjax5zbnnf7piq28ar6ywfdcf7k5w8sq1m0vx7";
        # date = 2019-07-09T17:53:15+08:00;
      };
    }
  );


}

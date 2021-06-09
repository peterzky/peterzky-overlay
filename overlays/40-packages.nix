final: prev:
{

  i3-wk-switch = final.python3Packages.i3-wk-switch;

  i3-quickterm = final.python3Packages.i3-quickterm;
  # nix-direnv enable flakes
  nix-direnv = (
    prev.nix-direnv.overrideAttrs (
      oldAttrs: rec {
        version = "1.4.0";
        src = prev.fetchFromGitHub {
          owner = "nix-community";
          repo = "nix-direnv";
          rev = "4cb1aa4f104ae5a28e8505f10e38c2779faaf23c";
          # date = 2021-06-03T18:55:23+02:00;
          sha256 = "04g8i6s8izmyksm5nc7jdzspfk61arq59jg30brj2l3y4a8prw7z";
        };
      }
    )
  ).override { enableFlakes = true; };

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
}

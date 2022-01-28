final: prev:
{

  leftwm-git = prev.callPackage ../pkgs/leftwm { };

  sway-unwrapped = (prev.sway-unwrapped.overrideAttrs (
    old: rec {
      version = "1.7";
      src = prev.fetchFromGitHub {
        # inherit (prev.lib.importJSON ../meta/sway.json) owner repo rev sha256;
        owner = "swaywm";
        repo = "sway";
        rev = "1.7";
        sha256 = "sha256-tHgw/NBQVnYmKuAp2C+Srrug3on3NE5BE87ThYqgQ2s=";
      };
      patches = builtins.filter
        (p: !builtins.elem p [
          ./load-configuration-from-etc.patch
        ])
        old.patches;
    }
  )).override {
    wlroots = prev.wlroots_0_15;
  };

  blesh = prev.callPackage ../pkgs/blesh { };

  cnip = prev.callPackage ../pkgs/cnip { };

  interception-tools-plugins = prev.interception-tools-plugins // {
    space2meta = prev.callPackage ../pkgs/space2meta { };
  };

  gfw-white-list = prev.callPackage ../pkgs/gfw-white-list { };

  sdcv-dict = prev.callPackage ../pkgs/sdcv-dict { };

  udp2raw = prev.callPackage ../pkgs/udp2raw { };

}

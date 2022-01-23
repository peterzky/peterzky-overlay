final: prev:
{

  leftwm-git = prev.callPackage ../pkgs/leftwm { };

  sway-unwrapped = (prev.sway-unwrapped.overrideAttrs (
    old: rec {
      version = "1.7";
      src = prev.fetchFromGitHub {
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
    meson = prev.meson_0_60;
  };

  blesh = prev.callPackage ../pkgs/blesh { };

  # files
  mycnip =
    prev.writeText "cnip.txt" (builtins.readFile ../files/cnip.txt);


  interception-tools-plugins = prev.interception-tools-plugins // {
    space2meta = prev.callPackage ../pkgs/space2meta { };
  };

  gfw-white-list = prev.callPackage ../pkgs/gfw-white-list { };

  sdcv-dict = prev.callPackage ../pkgs/sdcv-dict { };

}

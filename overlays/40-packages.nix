final: prev:
{

  leftwm-git = prev.callPackage ../pkgs/leftwm { };

  sway-unwrapped = (prev.sway-unwrapped.overrideAttrs (
    old: rec {
      version = "1.7";
      src = prev.fetchFromGitHub {
        inherit (prev.lib.importJSON ../meta/sway.json) owner repo rev sha256;
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

  # files
  mycnip =
    prev.writeText "cnip.txt" (builtins.readFile ../files/cnip.txt);


  interception-tools-plugins = prev.interception-tools-plugins // {
    space2meta = prev.callPackage ../pkgs/space2meta { };
  };

  gfw-white-list = prev.callPackage ../pkgs/gfw-white-list { };

  sdcv-dict = prev.callPackage ../pkgs/sdcv-dict { };

}

final: prev:
{

  blesh = prev.callPackage ../pkgs/blesh { };

  cnip = prev.callPackage ../pkgs/cnip { };

  flake-updater = prev.callPackage ../pkgs/flake-updater { };

  interception-tools-plugins = prev.interception-tools-plugins // {
    space2meta = prev.callPackage ../pkgs/space2meta { };
    cap2ctl = prev.callPackage ../pkgs/cap2ctl { };
  };

  gfw-white-list = prev.callPackage ../pkgs/gfw-white-list { };

  sdcv-dict = prev.callPackage ../pkgs/sdcv-dict { };

  udp2raw = prev.callPackage ../pkgs/udp2raw { };

  gamescope = prev.callPackage ../pkgs/gamescope { };

}

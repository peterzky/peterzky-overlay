final: prev:
{

  flake-updater = prev.callPackage ../pkgs/flake-updater { };

  interception-tools-plugins = prev.interception-tools-plugins // {
    space2meta = prev.callPackage ../pkgs/space2meta { };
    cap2ctl = prev.callPackage ../pkgs/cap2ctl { };
  };

  sdcv-dict = prev.callPackage ../pkgs/sdcv-dict { };

}

final: prev:
{
  sws = prev.callPackage ../pkgs/shell-script/sws {};

  audio-switch-menu = prev.callPackage ../pkgs/shell-script/audio-switch-menu.nix {};

  screen-dict = prev.callPackage ../pkgs/shell-script/screen-dict.nix {};

  volume-ctl = prev.callPackage ../pkgs/shell-script/volume-ctl.nix {};

  lf-pv = prev.callPackage ../pkgs/shell-script/lf-pv.nix {};
}

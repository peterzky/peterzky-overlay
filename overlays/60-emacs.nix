final: prev:
let
  my-epkg-overrides = epkgs: epkgs // {
    my-speed-type = epkgs.trivialBuild rec {
      inherit (epkgs) emacs;
      pname = "speed-type";
      version = "local";
      src = ../pkgs/emacs/speed-type;
    };
  };
in
{
  inherit my-epkg-overrides;
}

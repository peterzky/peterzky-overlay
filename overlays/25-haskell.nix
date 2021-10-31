final: prev:
let
  overrides = hsfinal: hsprev: {
    xmonad = prev.haskell.lib.overrideCabal hsprev.xmonad (_: rec {
      src = prev.fetchFromGitHub {
        owner = "xmonad";
        repo = "xmonad";
        rev = "e1daf46c751338db551e107cd2a1bdeec9c39dee";
        # date = 2021-10-29T12:24:30+01:00;
        sha256 = "02mpj8nalrwazx2ykdw294qxnk501rakjnvy6q3mp1g9izca1spc";
      };
      version = prev.lib.concatStrings
        [
          "0.16.99999"
          "-"
          (prev.lib.substring 0 5 src.rev)
        ];
      patches = [ ];
      editedCabalFile = null;
    }
    );

    xmonad-contrib = prev.haskell.lib.overrideCabal hsprev.xmonad-contrib (_: rec {
      src = prev.fetchFromGitHub {
        owner = "xmonad";
        repo = "xmonad-contrib";
        rev = "f6bcf094e122eff0629d315c4fd511c150d839f6";
        # date = 2021-10-30T22:27:09+02:00;
        sha256 = "0y8k4msa45xl084x8ln2sahj2m548d082qawq89drx0c45pg3qmc";
      };
      version = prev.lib.concatStrings
        [
          "0.16.999"
          "-"
          (prev.lib.substring 0 5 src.rev)
        ];
      doCheck = false;
      editedCabalFile = null;
    }
    );

  };
in
{
  haskellPackages = prev.haskellPackages.override {
    inherit overrides;
  };
}

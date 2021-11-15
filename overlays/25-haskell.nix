final: prev:
let
  overrides = hsfinal: hsprev: {
    xmonad = prev.haskell.lib.overrideCabal hsprev.xmonad (_: rec {
      src = prev.fetchFromGitHub {
        owner = "xmonad";
        repo = "xmonad";
        rev = "a902fefaf1f27f1a21dc35ece15e7dbb573f3d95";
        # date = 2021-11-04T11:05:14+00:00;
        sha256 = "1lgcx79pwi5g13la8d7sbznvksvswljpqzk1zx1si5j7dvwqh8f8";
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
        rev = "42dec50c17712476bde02042a3249e143f458ce2";
        # date = 2021-11-08T11:46:05+01:00;
        sha256 = "082sfbxx8671p2rswvdwfi46zf8v8359zchacr9q7cw30k9bjwms";
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

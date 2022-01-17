final: prev:
let
  overrides = hsfinal: hsprev: {
    xmonad = prev.haskell.lib.overrideCabal hsprev.xmonad (_: rec {
      src = prev.fetchFromGitHub {
        owner = "xmonad";
        repo = "xmonad";
        rev = "e25d090112f2a76364a10b88a729b8586c18145b";
        # date = 2021-12-11T19:54:05+01:00;
        sha256 = "01ljj4brzb4wxmhrlgvfm8d67k6avl1hq9l8qjm50l4hgjks3ijd";
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
        rev = "0a6048c66d6421a85c86f7c7e0d6aa65a920c06d";
        # date = 2022-01-05T15:06:17+01:00;
        sha256 = "1qn5l1nfzwxchx9qfgwxsq1va0b01abmy1vkc60ykfwydw6026fz";
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

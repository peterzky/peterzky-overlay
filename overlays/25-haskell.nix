final: prev:
let
  overrides = hsfinal: hsprev: {
    xmonad = prev.haskell.lib.overrideCabal hsprev.xmonad (_: rec {
      src = prev.fetchFromGitHub {
        owner = "xmonad";
        repo = "xmonad";
        rev = "b5b95e27ce94c51f07a0613674749278af1f5f6c";
        # date = 2021-10-17T10:14:02+02:00;
        sha256 = "0v7vxnn0sqrahkj08rfam703rl93ks9g2wy10dlcpzsvb5b85j4s";
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
        rev = "e0c7e35b3dcdf0e1f9ceccf9c11b3c053ec7cf61";
        # date = 2021-10-19T21:54:01+02:00;
        sha256 = "0xajhmwkjybvnfw05xwvi726q94zggysxb7rhd25ccyaqg4k821a";
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

self: super:
let
  libPath = with super;
    lib.concatStringsSep ":" [
      "${
        lib.getLib libgccjit
      }/lib/gcc/${stdenv.targetPlatform.config}/${libgccjit.version}"
      "${lib.getLib stdenv.cc.cc}/lib"
      "${lib.getLib stdenv.glibc}/lib"
    ];

in let
  emacsGccPGtk = builtins.foldl' (drv: fn: fn drv) super.emacs [

    (drv: drv.override { srcRepo = true; })

    (drv:
      drv.overrideAttrs (old: {
        name = "emacs-pgtk-native-comp";
        version = "28.0.50";
        src = super.fetchFromGitHub {
          owner = "flatwhatson";
          repo = "emacs";
          rev = "17aa4b9be072084c72a8725252274a7466dfad92";
          sha256 = "039cskvfl8jh20jc2cb42d9rim1697wgvkqy0wahpd1yyqjr8fqi";
        };

        configureFlags = old.configureFlags ++ [ "--with-pgtk" ];

        patches = [
          (super.fetchpatch {
            name = "clean-env.patch";
            url =
              "https://raw.githubusercontent.com/nix-community/emacs-overlay/master/patches/clean-env.patch";
            sha256 = "0lx9062iinxccrqmmfvpb85r2kwfpzvpjq8wy8875hvpm15gp1s5";
          })
          (super.fetchpatch {
            name = "tramp-detect-wrapped-gvfsd.patch";
            url =
              "https://raw.githubusercontent.com/nix-community/emacs-overlay/master/patches/tramp-detect-wrapped-gvfsd.patch";
            sha256 = "19nywajnkxjabxnwyp8rgkialyhdpdpy26mxx6ryfl9ddx890rnc";
          })
        ];

        postPatch = old.postPatch + ''
          substituteInPlace lisp/loadup.el \
          --replace '(emacs-repository-get-version)' '"master"' \
          --replace '(emacs-repository-get-branch)' '"master"'
        '';

      }))
    (drv: drv.override { nativeComp = true; })
  ];
in {

  inherit emacsGccPGtk;

  emacsGccWrapped = super.symlinkJoin {
    name = "emacsGccWrapped-28.0.50";
    version = "28.0.50";
    paths = [ emacsGccPGtk ];
    buildInputs = [ super.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/emacs \
      --set LIBRARY_PATH ${libPath}
    '';
    meta.platforms = super.stdenv.lib.platforms.linux;
    passthru.nativeComp = true;
    src = emacsGccPGtk.src;
  };
}

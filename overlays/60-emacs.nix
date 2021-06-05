final: prev:
let
  my-epkg-overrides = epkgs:
    let
      inherit (epkgs) emacs;
      inherit (prev) stdenv fetchFromGitHub fetchFromGitLab fetchgit;
      compileElisp = prev.callPackage ../pkgs/emacs/builder.nix;
      noCompileElisp = prev.callPackage ../pkgs/emacs/no-build.nix;
    in
      epkgs // {

        my-anki = compileElisp {
          name = "my-anki";
          src = ../pkgs/emacs/my-anki;
          buildInputs = with epkgs; [ org anki-editor dash request ];
        };

        git-undo = compileElisp {
          name = "git-undo";
          src = fetchFromGitHub {
            owner = "jwiegley";
            repo = "git-undo-el";
            rev = "cf31e38e7889e6ade7d2d2b9f8719fd44f52feb5";
            # date = 2019-12-21T11:05:45-08:00;
            sha256 = "10f9h8dby3ygkjqwizrif7v1wpwc8iqam5bvayahrabs87s0lnbi";
          };
        };

        my-speed-type = compileElisp {
          name = "my-speed-type";
          src = ../pkgs/emacs/speed-type;
          buildInputs = with epkgs; [ evil org ];
        };

        org-roam-v2 = compileElisp {
          emacs = prev.emacsPgtkGcc;
          name = "org-roam";
          src = fetchFromGitHub {
            owner = "org-roam";
            repo = "org-roam";
            rev = "2.0.0a1";
            sha256 = "05aqqvq3vxfj1g6kbqli0dpmrlplmzq14lazcfw5sq1km48irh60";
          };

          buildInputs = with epkgs; [
            dash
            emacsql
            emacsql-sqlite3
            f
            org
            s
            magit-section
          ];

        };

      };
  peter-emacs-config = prev.writeText "default.el"
    (builtins.readFile ../files/pmacs.el);



in
{
  inherit my-epkg-overrides;
  # minimal emacs with selective packages
  pmacs = prev.emacs.pkgs.withPackages (
    epkgs: (
      with epkgs.melpaStablePackages; [
        (
          prev.runCommand "default.el" {} ''
            mkdir -p $out/share/emacs/site-lisp
            cp ${peter-emacs-config} $out/share/emacs/site-lisp/default.el
          ''
        )
        company
        magit
        projectile
        use-package
        selectrum
        crux
        nix-mode
      ]
    )
  );
}

final: prev:
let
  my-epkg-overrides = epkgs:
    let
      inherit (epkgs) emacs;
      inherit (prev) stdenv fetchFromGitHub fetchFromGitLab fetchgit;
      compileElisp = prev.callPackage ../pkgs/emacs/builder.nix;
      noCompileElisp = prev.callPackage ../pkgs/emacs/no-build.nix;
    in
      {
        my-anki = compileElisp {
          name = "my-anki";
          src = ../pkgs/emacs/my-anki;
          buildInputs = with epkgs; [ org anki-editor dash request ];
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

        modus-themes = compileElisp {
          name = "modus-themes";
          src = fetchFromGitLab {
            owner = "protesilaos";
            repo = "modus-themes";
            rev = "6122a90e037b73d617163c7c9ae1bfb1e0a47822";
            # date = 2020-11-14T09:29:21+02:00;
            sha256 = "0xpjzcvyh4dpqfaj4f6h1xgpxqd1nbyg8xwdsq3a6sadm1f3x73c";
          };
        };
      };

in
{
  inherit my-epkg-overrides;
}

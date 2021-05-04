final: prev:
let
  my-epkg-overrides = epkgs:
    let
      inherit (epkgs) emacs;
      inherit (prev) stdenv fetchFromGitHub fetchFromGitLab fetchgit;
      compileElisp = prev.callPackage ./pkgs/emacs/builder.nix;
    in
      {
        my-anki = compileElisp {
          name = "my-anki";
          src = ./pkgs/emacs/my-anki;
          buildInputs = with epkgs; [ org anki-editor dash request ];
        };

        my-speed-type = compileElisp {
          name = "my-speed-type";
          src = ./pkgs/emacs/speed-type;
          buildInputs = with epkgs; [ evil org ];
        };

        org-roam-v2 = compileElisp {
          name = "org-roam";
          # nix-prefetch-git --branch-name v2 https://github.com/org-roam/org-roam.git
          src = fetchgit {
            url = "https://github.com/org-roam/org-roam.git";
            branchName = "v2";
            rev = "9da45b54f3ac69994de8f28a41dfefe3d786d875";
            # date = 2021-04-16T13:02:48+08:00;
            sha256 = "1k5jqmnrsgm9hwh060xi27k2klgi9vk1hyd7nhqm0vn2cvp3js2v";
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

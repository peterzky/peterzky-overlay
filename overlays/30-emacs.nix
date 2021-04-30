self: super:
let
  my-epkg-overrides = epkgs:
    let
      inherit (epkgs) emacs;
      inherit (super) stdenv fetchFromGitHub fetchFromGitLab fetchgit;
      # compile lisp code with same version of emacs
      compileElisp = super.callPackage ./emacs/builder.nix;
    in
      {
        my-wiki = compileElisp {
          name = "my-wiki";
          src = ../packages/emacs/wiki;
          buildInputs = with epkgs; [ ivy org counsel swiper dash ];
        };

        my-anki = compileElisp {
          name = "my-anki";
          src = ../packages/emacs/my-anki;
          buildInputs = with epkgs; [ org anki-editor dash request ];
        };

        my-speed-type = compileElisp {
          name = "my-speed-type";
          src = ../packages/emacs/speed-type;
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

        # tridactyl-mode = compileElisp {
        #   name = "tridactyl-mode";
        #   src = fetchFromGitHub {
        #     owner = "Fuco1";
        #     repo = "tridactyl-mode";
        #     rev = "0bbe8d94aef9faaf6d3a7e2955c1222fe96ea2e7";
        #     sha256 = "0jd1mg2k4hsfg30fg484br9g8ml10y8n0cljxkx3g6qb20aqdnqf";
        #     # date = 2018-09-23T00:18:10+02:00;
        #   };
        # };

        # valign = compileElisp {
        #   name = "valign";
        #   src = fetchFromGitHub {
        #     owner = "casouri";
        #     repo = "valign";
        #     rev = "455cb2c6f772a80f8aac40117ea4a9160ef47ac5";
        #     sha256 = "0x7h26k29454djscsbzbr4acxyiznxmkhqp6fwlq40mijngk52ac";
        #   };
        # };

        # yasnippet-snippets = (
        #   compileElisp {
        #     name = "yasnippet-snippets";
        #     src = fetchFromGitHub {
        #       owner = "AndreaCrotti";
        #       repo = "yasnippet-snippets";
        #       rev = "be823d7e1a1a46454d60a9f3dabb16b68b5dd853";
        #       sha256 = "0ak0drxlg3m2v4ya5chpgl82rcl7ic2nmnybhpw1qk51mcmv643y";
        #       # date = 2021-04-08T13:34:22+01:00;
        #     };
        #     buildInputs = with epkgs; [ yasnippet ];
        #   }
        # ).overrideAttrs (
        #   oldAttrs: rec {
        #     installPhase = ''
        #       mkdir -p $out/share/emacs/site-lisp
        #       install *.el* $out/share/emacs/site-lisp
        #       cp -r snippets $out/share/emacs/site-lisp/snippets
        #     '';
        #   }
        # );

      };

in
{

  inherit my-epkg-overrides;
}

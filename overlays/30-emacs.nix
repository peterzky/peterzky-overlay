self: super:
let
  my-epkg-overrides = epkgs:
    let
      inherit (epkgs) emacs;
      inherit (super) stdenv fetchFromGitHub fetchgit;
      compileElisp = super.callPackage ./emacs/builder.nix;
    in {
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
        # src = ../../../playground/org-roam;
        src = fetchFromGitHub {
          owner = "jethrokuan";
          repo = "org-roam";
          # branch = v2
          rev = "1440802b8b05ecb78975f406b51e531cd831e313";
          # date = 2021-04-05T21:35:58+08:00;
          sha256 = "10jrnjq65lpg1x8d7lqc537yai9m6pdnfbzwr87fcyv6f8yii8xn";
        };

        # current version of rx library not have anychar, use anything insdead.
        # patches = [ ../patches/org-roam-rx-fix.patch ];

        buildInputs = with epkgs; [ org dash s f company emacsql-sqlite3 ];

      };

      tridactyl-mode = compileElisp {
        name = "tridactyl-mode";
        src = fetchFromGitHub {
          owner = "Fuco1";
          repo = "tridactyl-mode";
          rev = "0bbe8d94aef9faaf6d3a7e2955c1222fe96ea2e7";
          sha256 = "0jd1mg2k4hsfg30fg484br9g8ml10y8n0cljxkx3g6qb20aqdnqf";
          # date = 2018-09-23T00:18:10+02:00;
        };
      };

      valign = compileElisp {
        name = "valign";
        src = fetchFromGitHub {
          owner = "casouri";
          repo = "valign";
          rev = "455cb2c6f772a80f8aac40117ea4a9160ef47ac5";
          sha256 = "0x7h26k29454djscsbzbr4acxyiznxmkhqp6fwlq40mijngk52ac";
        };
      };

      yasnippet-snippets = (compileElisp {
        name = "yasnippet-snippets";
        src = fetchFromGitHub {
          owner = "AndreaCrotti";
          repo = "yasnippet-snippets";
          rev = "d5ef8ed2b34798c1576f2fbfed858ee5486d1792";
          sha256 = "1b9410a6mvkqvarzfv1sbj9x6f6m8x7jh56gshndh1m4lhl2gf3p";
          # date = 2020-06-06T12:49:44+01:00;
        };
        buildInputs = with epkgs; [ yasnippet ];

      }).overrideAttrs (oldAttrs: rec {
        installPhase = ''
          mkdir -p $out/share/emacs/site-lisp
          install *.el* $out/share/emacs/site-lisp
          cp -r snippets $out/share/emacs/site-lisp/snippets
        '';
      });

    };

in {

  inherit my-epkg-overrides;
}

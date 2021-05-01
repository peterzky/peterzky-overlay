{
  description = "Peter's personal overlay";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      overlay = final: prev:
        let
          # emacs package
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



          # python overrides
          pythonOverrides = python-final: python-prev: {
            i3-wk-switch = prev.callPackage ./pkgs/python/i3-wk-switch {
              buildPythonPackage = python-prev.buildPythonPackage;
              i3ipc = python-prev.i3ipc;
            };
          };


          peterPkgs = rec {
            # emacs
            inherit my-epkg-overrides;
            # python
            python3 = prev.python3.override { packageOverrides = pythonOverrides; };

            i3-wk-switch = final.python3Packages.i3-wk-switch;
            # libs
            libqcef = prev.callPackage ./pkgs/libqcef.nix {};

            # files
            chnroute-ipset =
              prev.writeText "chnrout.ipset" (builtins.readFile ./files/chnroute.ipset);

            # packages
            wayst-git = prev.wayst.overrideAttrs (
              oldAttrs: rec {
                src = prev.fetchFromGitHub {
                  owner = "91861";
                  repo = "wayst";
                  rev = "e72ca78ef72c7b1e92473a98d435a3c85d7eab98";
                  # date = 2021-04-05T19:50:37+02:00;
                  sha256 = "112jajl34xl4i82bh9zal47jcqjmml6k6a0f985gz4v9ym4iaw2i";
                };
              }
            );

            nvd = prev.callPackage ./pkgs/nvd {};

            sws = prev.callPackage ./pkgs/shell-script/sws {};

            interception-tools-plugins = prev.interception-tools-plugins // {
              space2meta = prev.callPackage ./pkgs/space2meta {};
            };

            foot-git = prev.callPackage ./pkgs/foot {};

            wlroots-river = prev.callPackage ./pkgs/wlroots {};

            zig-git = prev.callPackage ./pkgs/zig-git {
              llvmPackages = prev.llvmPackages_11;
            };

            river = prev.callPackage ./pkgs/river {
              zig = final.zig-git;
              wlroots = final.wlroots-river;
            };

            v2ray = prev.callPackage ./pkgs/go/v2ray {};

            gfw-white-list = prev.callPackage ./pkgs/gfw-white-list {};

            san-francisco-font = prev.callPackage ./pkgs/san-francisco-font.nix {};

            my-sdcv-dict = prev.callPackage ./pkgs/sdcv-dict.nix {};

            input-fonts = prev.callPackage ./pkgs/input-font {};

            # script
            audio-switch-menu = prev.callPackage ./pkgs/shell-script/audio-switch-menu.nix {};

            screen-dict = prev.callPackage ./pkgs/shell-script/screen-dict.nix {};

            volume-ctl = prev.callPackage ./pkgs/shell-script/volume-ctl.nix {};

          };
        in
          peterPkgs // { inherit peterPkgs; };
    in
      flake-utils.lib.eachDefaultSystem (
        system:
          let
            pkgs = import nixpkgs { inherit system; };
            pkgs_full = import nixpkgs {
              inherit system;
              overlays = [ overlay ];
              config.allowUnfree = true;
            };

          in
            rec {
              packages = flake-utils.lib.flattenTree pkgs_full.peterPkgs;
            }
      ) // {
        nixosModules = import ./modules;
        inherit overlay;
      };
}

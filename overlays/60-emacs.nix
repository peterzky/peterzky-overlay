final: prev:
let
  my-epkg-overrides = epkgs:
    let
      _callPackage = prev.lib.callPackageWith (prev // epkgs);
    in
    epkgs // {

      tree-sitter-langs = _callPackage ../pkgs/emacs/tree-sitter-langs { };

      tsc = _callPackage ../pkgs/emacs/tsc { };

      # eglot use lisp library with emacs
      eglot = (epkgs.eglot.overrideAttrs (
        old: rec {
          pname = "eglot";
          ename = "eglot";
          version = "999";
          src = prev.fetchFromGitHub {
            inherit (prev.lib.importJSON ../meta/eglot.json) owner repo rev sha256;
          };
        }
      )).override
        {
          xref = null;
          project = null;
          flymake = null;
          jsonrpc = null;
          eldoc = null;
        };

      lsp-mode = epkgs.lsp-mode.overrideAttrs (
        old: rec {
          src = prev.fetchFromGitHub {
            owner = "emacs-lsp";
            repo = "lsp-mode";
            rev = "9b3a9215807af0727b514e8c7cf440bcc0bdad44";
            sha256 = "0wq2nrg7dfd5570q5s8w36z3c8brsdby1q9iqfxrab7v1byxzyd8";
          };

          # patches = [
          #   (prev.fetchpatch {
          #     url = "https://patch-diff.githubusercontent.com/raw/emacs-lsp/lsp-mode/pull/2531.patch";
          #     sha256 = "sha256-4f+lrz4xKmDuLdmPZdNH84zyVoluHsGBFHkky8CzwOA=";
          #   })
          # ];
          # enable lsp plist optmization
          postPatch = ''
            substituteInPlace lsp-protocol.el \
            --replace '(getenv "LSP_USE_PLISTS")' 't'
          '';
        }
      );
    };
in
{
  inherit my-epkg-overrides;
}

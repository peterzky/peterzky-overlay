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
      eglot = epkgs.eglot.override {
        xref = null;
        project = null;
        flymake = null;
      };
    };
in
{
  inherit my-epkg-overrides;
}

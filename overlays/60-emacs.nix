final: prev:
let
  my-epkg-overrides = epkgs:
    let
      _callPackage = prev.lib.callPackageWith (prev // epkgs);
    in
    epkgs // {

      tree-sitter-langs = _callPackage ../pkgs/emacs/tree-sitter-langs { };

      tsc = _callPackage ../pkgs/emacs/tsc { };
    };
in
{
  inherit my-epkg-overrides;
}

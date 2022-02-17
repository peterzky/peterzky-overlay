final: prev:
with builtins;
with prev.lib;
let
  path = ./overlays;
  overlays = map (n: import (path + ("/" + n))) (
    filter
      (
        n:
        match ".*\\.nix" n != null
        || pathExists (path + ("/" + n + "/default.nix"))
      )
      (attrNames (readDir path))
  );
in
composeManyExtensions overlays final prev

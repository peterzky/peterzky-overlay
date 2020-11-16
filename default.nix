self: super:
with super.lib;
with builtins;
let
  path = ./overlays;
  overlays = map (n: import (path + ("/" + n))) (filter (n:
    match ".*\\.nix" n != null
    || pathExists (path + ("/" + n + "/default.nix")))
    (attrNames (readDir path)));
in foldl' (flip extends) (_: super) overlays self

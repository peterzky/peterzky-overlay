{ writeShellScriptBin }:

writeShellScriptBin "sws" (builtins.readFile ./sws)

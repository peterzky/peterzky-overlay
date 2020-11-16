{ writeShellScriptBin, wmctrl, dmenu }:

writeShellScriptBin "ws_menu" (builtins.readFile ./ws_menu.sh)

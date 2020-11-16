{ writeShellScriptBin, wmctrl, dmenu }:

writeShellScriptBin "wofi-bluetooth" (builtins.readFile ./wofi-bluetooth)

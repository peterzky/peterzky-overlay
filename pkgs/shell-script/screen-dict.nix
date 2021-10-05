{ writeShellScriptBin
  # , wl-clipboard,
, libnotify
, xclip
}:
# word=`${wl-clipboard}/bin/wl-paste -np`
writeShellScriptBin "dict" ''
  word=`${xclip}/bin/xclip -rmlastnl -o`
  explain=`sdcv -n -u 朗道英汉字典5.0 "$word" | grep -v '\-\->' | grep -P '[\p{Han}]'`
  ${libnotify}/bin/notify-send "$explain"
''

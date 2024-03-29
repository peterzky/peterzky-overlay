{ writeShellScriptBin
, wl-clipboard
, libnotify
  # , xclip
}:
# word=`${xclip}/bin/xclip -rmlastnl -o`
writeShellScriptBin "dict" ''
  word=`${wl-clipboard}/bin/wl-paste -np`
  explain=`sdcv -n -u 朗道英汉字典5.0 "$word" | grep -v '\-\->' | grep -P '[\p{Han}]'`
  ${libnotify}/bin/notify-send "$explain"
''

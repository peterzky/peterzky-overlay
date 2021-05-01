{ writeShellScriptBin, dmenu, libnotify }:
writeShellScriptBin "audio-switch-menu" ''
  # shift audio stream to new output
  function shift_stream () {
      pactl set-default-sink "$1"
      pactl list short sink-inputs|while read stream; do
          streamId=$(echo $stream|cut '-d ' -f1)
          echo "moving stream $streamId"
          pactl move-sink-input "$streamId" "$1"
      done
  }
  choices=$(pactl list short sinks | awk '{print $2}')
  chosen=$(echo -e "$choices" | ${dmenu}/bin/dmenu -i -l 4 -p Audio)

  if [ -z "$chosen" ]; then
      exit 0
  else
      shift_stream "$chosen"
      ${libnotify}/bin/notify-send "Auido switch to $chosen"
  fi
''

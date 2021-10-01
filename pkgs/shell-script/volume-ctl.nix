{ writeShellScriptBin, pamixer, dunst, pulseaudio }:

writeShellScriptBin "volume-ctl" ''
  id=/tmp/volume_nofity

  function get_id {
    if [ ! -f $id ]; then
      echo 2593 > $id
    fi
    cat $id
  }

  function set_id {
    read cur_id < $id
    if [[ $cur_id -ne $1 ]]; then
      echo $1 > $id
    fi
  }

  function get_volume {
    ${pamixer}/bin/pamixer --get-volume
  }

  function is_mute {
    ${pamixer}/bin/pamixer --get-mute > /dev/null
  }

  function send_notification_mute {
    if is_mute ; then
    ${dunst}/bin/dunstify -r 2593 -u normal -t 500 "mute"
    else
        send_notification_vol
    fi
  }

  function send_notification_vol {
     volume=$(get_volume)
     notify_id=$(get_id)
     bar=$(seq --separator="—" 0 "$((volume / 10))" | sed 's/[0-9]//g')
     set_id $(${dunst}/bin/dunstify -p -r $notify_id -u normal -t 1000 "Vol : $volume    $bar")
  }

  case $1 in
    up)
      ${pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +2%
      send_notification_vol
      ;;
    down)
      ${pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -2%
      send_notification_vol
      ;;
    mute)
      ${pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle
      send_notification_mute
      ;;
  esac
''

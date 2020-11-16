self: super:

{
  my-youtube-dl-config = super.writeText "youtube-dl-config" ''
    -o ~/Downloads/%(title)s.%(ext)s
  '';

  ws_menu = super.callPackage ../packages/shellscript/dwm_ws_menu { };

  audio-switch-menu = super.writeShellScriptBin "audio-switch-menu" ''
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
    chosen=$(echo -e "$choices" | ${super.dmenu}/bin/dmenu -i -l 4 -p Audio)

    if [ -z "$chosen" ]; then
        exit 0
    else
        shift_stream "$chosen"
        ${super.libnotify}/bin/notify-send "Auido switch to $chosen"
    fi
  '';

  screen_dict = super.writeShellScriptBin "dict" ''
    word=`wl-paste -np`
    explain=`sdcv -n -u 朗道英汉字典5.0 "$word" | grep -v '\-\->' | grep -P '[\p{Han}]'`
    ${super.libnotify}/bin/notify-send "$explain"
  '';

  volume-ctl = super.writeShellScriptBin "volume-ctl" ''
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
      ${super.pamixer}/bin/pamixer --get-volume
    }

    function is_mute {
      ${super.pamixer}/bin/pamixer --get-mute > /dev/null
    }

    function send_notification_mute {
      if is_mute ; then
      ${super.dunst}/bin/dunstify -r 2593 -u normal -t 500 "mute"
      else
          send_notification_vol
      fi
    }

    function send_notification_vol {
       volume=$(get_volume)
       notify_id=$(get_id)
       bar=$(seq --separator="—" 0 "$((volume / 10))" | sed 's/[0-9]//g')
       set_id $(${super.dunst}/bin/dunstify -p -r $notify_id -u normal -t 1000 "Vol : $volume    $bar")
    }

    case $1 in
      up)
        pactl set-sink-volume @DEFAULT_SINK@ +2%
        send_notification_vol
        ;;
      down)
        pactl set-sink-volume @DEFAULT_SINK@ -2%
        send_notification_vol
        ;;
      mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        send_notification_mute
        ;;
    esac
        '';

  org-capture = super.writeShellScriptBin "org-capture" ''
    screen_res=$(${super.xorg.xdpyinfo}/bin/xdpyinfo | grep -oP 'dimensions:\s+\K\S+')
    screen_x=$(echo $screen_res | cut -dx -f1)
    screen_y=$(echo $screen_res | cut -dx -f2)

    ratio_x=0.5
    ratio_y=0.5

    h=$(${super.bc}/bin/bc <<< "$screen_x*$ratio_x*0.14064697609")
    w=$(${super.bc}/bin/bc <<< "$screen_y*$ratio_y*0.0551181102388")
    x=$(${super.bc}/bin/bc <<< "$screen_x*(1 - $ratio_x)/2")
    y=$(${super.bc}/bin/bc <<< "$screen_y*(1 - $ratio_y)/2")

    geo=$(printf %.fx%.f+%.f+%.f $h $w $x $y)

    export TRANSIENT=1
    st -t transient -g $geo -e emacsclient -nw -e '(org-capture nil "i")'
  '';

  screenshot = super.writeShellScriptBin "screenshot" ''
    image=/tmp/screenshot.png
    ${super.maim}/bin/maim -s | ${super.xclip}/bin/xclip -selection clipboard -t image/png
    sleep 0.1
    xclip -selection clipboard -t image/png -o > $image
    sleep 0.1
    ${super.feh}/bin/feh --info 'echo "1:save  2:delete  3:search"' \
                   --scale-down \
                   --auto-zoom \
                   --no-screen-clip \
                   --action1 "cp %F /home/peterzky/Sync/sync/screenshot/%V.png;rm %F; notify-send 'screenshot saved!'" \
                   --action2 "rm %F; notify-send 'screenshot deleted!'" \
                   --action3 "$HOME/.bin/imgsearch.py %F;rm %F; notify-send 'search image...'" \
                   /tmp/screenshot.png \
                   || notify-send "not screenshot available"
                 '';

  shutdown-clean = super.writeShellScriptBin "shutdown-clean" ''
    # close all open windows gracefully without closing the Desktop environment
    WIN_IDs=$(${super.wmctrl}/bin/wmctrl -l | grep -vwE "Desktop$|xfce4-panel$" | cut -f1 -d' ')

    for i in $WIN_IDs; do
        ${super.wmctrl}/bin/wmctrl -ic "$i"
    done

    # Keep checking and waiting until all windows are closed (you probably don't need this section)
    while test $WIN_IDs; do
        sleep 0.1;
        WIN_IDs=$(${super.wmctrl}/bin/wmctrl -l | grep -vwE "Desktop$|xfce4-panel$" | cut -f1 -d' ')
    done

    sleep 3;

    sync

    sudo systemctl poweroff
  '';

}

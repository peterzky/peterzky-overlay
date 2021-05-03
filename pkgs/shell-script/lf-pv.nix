{ writeShellScript, catimg, ffmpegthumbnailer }:
writeShellScript "pv.sh" ''
        CACHE="$HOME/.cache/lf/thumbnail.$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y'\
          -- "$(readlink -f "$1")" | sha256sum | awk '{print $1}')"

        image() {
          ${catimg}/bin/catimg "$1" -w $(expr $2 \* 2 - 5)
        }

        case "$1" in
          *.bmp|*.jpg|*.jpeg|*.png|*.xpm|*.webp|*.gif)
             image "$1" "$2"
             ;;
          *.avi|*.mp4|*.wmv|*.dat|*.3gp|*.ogv|*.mkv|*.mpg|*.mpeg|*.vob|*.fl[icv]|*.m2v|*.mov|*.webm|*.ts|*.mts|*.m4v|*.r[am]|*.qt|*.divx)
  		    [ ! -f "$CACHE.jpg" ] && \
  			  ${ffmpegthumbnailer}/bin/ffmpegthumbnailer -i "$1" -o "$CACHE.jpg" -s 0 -q 5
     		    image "$CACHE.jpg" "$2"
  		       ;;

        esac
''

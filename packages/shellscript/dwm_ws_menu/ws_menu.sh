#!/usr/bin/env bash

declare -A web_dict=(
    ["Firefox"]="firefox"
    ["Private"]="firefox --private-window"
    ["Chromium"]="chromium"
)

declare -A msg_dict=(
    ["Cmus"]="st -e cmus"
    ["WeChat"]="chromium --app='https://wx.qq.com'"
    ["MusicBox"]="st -e musicbox"
)

declare -A doc_dict=(
    ["Okular"]="okular"
    ["Anki"]="anki"
    ["Zeal"]="zeal"
)

declare -A org_dict=(
    ["Email"]="TRANSIENT=1 st -e emacsclient -nw -e '(mu4e)'"
    ["Rss"]="TRANSIENT=1 st -e emacsclient -nw -e '(elfeed)'"
    ["Agenda"]="TRANSIENT=1 st -e emacsclient -nw -e '(org-agenda nil \"d\")'"
)

dmenu_from_dict() {
    local -n dict=$1
    local choices=$(printf "%s\n" "${!dict[@]}")
    local chosen=$(echo -e "$choices" | dmenu "${@:2}")

    if [[ -n "${dict[$chosen]}" ]]; then
	eval "${dict[$chosen]}"
    else
	exit 0
    fi
}

current_workspace=$(wmctrl -d | grep -w '*' | cut -d: -f5)

case $current_workspace in
    WEB)
	dmenu_from_dict web_dict "$@"
        ;;

    DOC)
	dmenu_from_dict doc_dict "$@"
	;;
    ORG)
	dmenu_from_dict org_dict "$@"
	;;
    MSG)
	dmenu_from_dict msg_dict "$@"
	;;
    *)
	dmenu_run "$@"
	;;
esac

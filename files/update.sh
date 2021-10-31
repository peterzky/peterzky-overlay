#!/usr/bin/env nix-shell
#!nix-shell -i bash -p curl iprange
update_list() {
    diff /tmp/cnip.txt ./cnip.txt
    while true; do
	read -p "Update List?(y/n): " yn
	case $yn in
            [Yy]* ) break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
	esac
    done
    cat /tmp/cnip.txt > ./cnip.txt
    echo "List has been updated."
}

download_apnic() {
    echo "Downloading China IPs from APNIC"
    curl 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | grep ipv4 | \
	grep CN | awk -F\| '{ printf("%s/%d\n", $4, 32-log($5)/log(2)) }' | \
	iprange --optimize > /tmp/apnic.txt
    echo "Apnic download completed"
}

download_github() {
    echo "Downloading China IPs from Github misakaio/chnroutes2"
    curl -Ls https://github.com/misakaio/chnroutes2/raw/master/chnroutes.txt | \
	sed '/^#/d' > /tmp/chnroutes2.txt
}

# merge_ips() {
#     iprange --optimize /tmp/apnic.txt /tmp/chnroutes2.txt > /tmp/cnip.txt
#     echo "Merge completed. total records: '$(wc -l /tmp/cnip.txt)'"
# }

merge_ips() {
    iprange --optimize /tmp/apnic.txt > /tmp/cnip.txt
    echo "Merge completed. total records: '$(wc -l /tmp/cnip.txt)'"
}



# main
if ! [ -e /tmp/apnic.txt ]; then
    download_apnic
fi
# if ! [ -e /tmp/chnroutes2.txt ]; then
#     download_github
# fi
merge_ips
update_list

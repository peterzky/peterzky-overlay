#!/usr/bin/env nix-shell
#!nix-shell -i bash -p curl iprange
update_list() {
    cat /tmp/chnroute.ipset > ./chnroute.ipset
        echo "List has been updated."
    }

echo "Downloading China IPs"
    curl 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | grep ipv4 | \
      grep CN | awk -F\| '{ printf("%s/%d\n", $4, 32-log($5)/log(2)) }' | \
    iprange --optimize > /tmp/chnroute.txt

    echo "create chnroute hash:net family inet hashsize 2048 maxelem 65536" | sort > /tmp/chnroute.ipset

    echo "Creating ipset file"
    while read ip; do
        echo add chnroute $ip >> /tmp/chnroute.ipset
    done < /tmp/chnroute.txt

    diff /tmp/chnroute.ipset ./chnroute.ipset

    while true; do
        read -p "Update List?(y/n): " yn
        case $yn in
            [Yy]* ) update_list;break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done

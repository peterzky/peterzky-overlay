#!/usr/bin/env bash
update_list() {
    cat /tmp/chnroute.ipset > ./chnroute.ipset
        echo "List has been updated."
    }

echo "Downloading China IPs"
curl -Ls https://github.com/misakaio/chnroutes2/raw/master/chnroutes.txt | sed '/^#/d' > /tmp/chnroute.txt

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

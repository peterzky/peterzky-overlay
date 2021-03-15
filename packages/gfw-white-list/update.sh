#!/usr/bin/env nix-shell
#!nix-shell -i bash -p curl jq

# get current rev from nix file
old_rev=$(sed -En 's/.*\brev = "(.*?)".*/\1/p' default.nix)

# get rev from github
function fetch_head_rev {
    curl "https://api.github.com/repos/felixonmars/dnsmasq-china-list/commits?sha=master&per_page=1" |
	jq '.[0].sha' --raw-output
}

new_rev=$(fetch_head_rev)

echo "Updating GFW-White-List" >&2
echo "current revision: $old_rev" >&2
echo "remote revision: $new_rev" >&2


# if not equal use the newer rev and sha256

if [[ $new_rev != $old_rev ]]; then
    echo "Prefetching new version..." >&2
    { read hash; read store_path; } < <(
	nix-prefetch-url --unpack --print-path "https://codeload.github.com/felixonmars/dnsmasq-china-list/zip/$new_rev"
    )

    sed --in-place \
	-e "s/\brev = \".*\"/rev = \"$new_rev\"/" \
	-e "s/\bsha256 = \".*\"/sha256 = \"$hash\"/" \
	default.nix
fi

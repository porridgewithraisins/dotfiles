#! /usr/bin/env bash

set -euo pipefail

lasthash="$(cat lasthash)"

newhash="$(pacman -Q | md5sum | cut -d' ' -f1)"

test "$lasthash" = "$newhash" && echo "hash is same" && exit 0

pacman -Q > packages_$(date '+%Y-%m-%dT%H:%M:%S%z').txt
echo "$newhash" > lasthash

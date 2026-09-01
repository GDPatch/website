#!/usr/bin/env sh
# SPDX-License-Identifier: LGPL-2.1-only
# ./run_with_gdpatch.sh %command%

# Gracefully borrowed from UnityDoorstop who solved this problem in the past; this file is licensed as LGPL as a result
# https://github.com/NeighTools/UnityDoorstop/blob/71c5e43f4a17bff6c1d84a769079b8ddfbbc7210/assets/nix/run.sh#L68
for a in "$@"; do
    if [ "$a" = "SteamLaunch" ]; then
        rotated=0; max=$#
        while [ $rotated -lt $max ]; do
            if [ "$1" != "${1#"${PWD%/}/"}" ]; then
                to_rotate=$(($# - rotated))
                set -- "$@" "$0"
                while [ $((to_rotate-=1)) -ge 0 ]; do
                    set -- "$@" "$1"
                    shift
                done
                exec "$@"
            else
                set -- "$@" "$1"
                shift
                rotated=$((rotated+1))
            fi
        done
        echo "Could not determine game executable launched by Steam" 1>&2
        exit 1
    fi
done

export LD_LIBRARY_PATH="$(pwd):${LD_LIBRARY_PATH}"
export LD_PRELOAD="libgdpatch_loader.so:${LD_PRELOAD}"
exec "$@"

#!/usr/bin/env bash

# 2025-07-01
# https://github.com/musinsky/config/blob/master/bash/scripts/muke-cvmfs-mounting.sh

print_status_usage() {
    # 1st) status
    printf 'List of available cvmfs repositories:\n'
    printf '%s\n' "${CVMFS_REPOS[@]}"
    printf '\nList of mounted cvmfs repositories:\n'
    findmnt --source cvmfs2 || printf 'none cvmfs repository mounted\n'
    # 2nd) usage
    local bname=${0##*/}   # basename in bash
    printf '\nUsage: %s <command>   # root privileges required\n' "$bname"
    printf 'commands are:\n'
    printf '   mount      # mount all repositories\n'
    printf '   umount     # umount all repositories\n'
    exit 1
}
mount_repo() {
    local repo="$1"
    local repo_dir="$CVMFS_DIR/$repo"
    # works correct if already mounted
    mkdir -p "$repo_dir" &&
        mount -t cvmfs "$repo" "$repo_dir" &&
        printf "Repository '%s' mounted on '%s'\n\n" "$repo" "$repo_dir"
}
umount_repo() {
    local repo="$1"
    local repo_dir="$CVMFS_DIR/$repo"
    # works correct if not mounted
    umount "$repo_dir" && printf "Repository '%s' unmounted" "$repo" &&
        rmdir "$repo_dir" && printf ", dir '%s' removed\n\n" "$repo_dir"
}

CVMFS_DIR="/cvmfs"
CVMFS_REPOS=("cvmfs-config.cern.ch")
CVMFS_REPOS+=("sft.cern.ch" "sft-nightlies.cern.ch")
CVMFS_REPOS+=("alice.cern.ch" "alice-nightlies.cern.ch" "alice-ocdb.cern.ch")

# # parsing 'cvmfs_config showconfig' command output is better (but slower) than
# # parsing '/etc/cvmfs/default.local' file
# IFS=',' read -r -a CVMFS_REPOS <<< "$(cvmfs_config showconfig -s none-repo |
#     grep 'CVMFS_REPOSITORIES' | cut -d '=' -f 2 | cut -d ' ' -f 1)"
# printf 'CVMFS_REPOSITORIES from cvmfs_config: %s\n' "${CVMFS_REPOS[@]}"

[ "$#" -ne 1 ] && print_status_usage # just one argument
[ "$(id -u)" -ne 0 ] && { printf 'root privileges required\n'; exit 1; }

case "$1" in
    mount)
        for rrr in "${CVMFS_REPOS[@]}"
        do
            mount_repo "$rrr"
        done
        ;;
    umount)
        for rrr in "${CVMFS_REPOS[@]}"
        do
            umount_repo "$rrr"
        done
        ;;
    *)
        print_status_usage
        ;;
esac

#!/bin/bash

# Directories
DIR1="$HOME/cnfg.bak"
DIR2="$DIR1/sync"
DIR3="$DIR2/BNT"
DIR4="$DIR2/git"
DIR5="$HOME/.config/git"
DIR6="$DIR1/fstb"
DIR7="/etc/fstab"
# DIR8="$DIR1/crtb"
# DIR9="/var/spool/cron/crontabs"

# File pairs for syncing
declare -A files=(
    ["$DIR3/.bash_aliases"]="$HOME/.bash_aliases"
    ["$DIR3/.bashrc"]="$HOME/.bashrc"
    ["$DIR3/.inputrc"]="$HOME/.inputrc"
    ["$DIR3/.dircolors"]="$HOME/.dircolors"
    ["$DIR4/config"]="$DIR5/config"
    ["$DIR4/ignore"]="$DIR5/ignore"
    # ["$DIR6/fstab.P5550#2"]="$DIR7/fstab"
    # ["$DIR6/fstab.P5550#2"]="$DIR7/fstab"
)

# Function to synchronize files
sync_files() {
    local src_1="$1"
    local src_2="$2"

    # Sync src to dest only if src is newer
    if [ "$src_1" -nt "$src_2" ]; then
        echo "The $src_1 is newer than the $src_2"
        echo "Copying $src_1 -> $src_2"
        rsync -auv "$src_1" "$src_2"
    elif [ "$src_1" -ot "$src_2" ]; then
        echo "The $src_2 is newer than the $src_1"
        echo "Copying $src_2 -> $src_1"
        rsync -auv "$src_2" "$src_1"
    else
        echo "Both files are in sync: $src_1 and $src_2"
    fi
}

# Loop over file pairs to sync them
for src_1 in "${!files[@]}"; do
    src_2="${files[$src_1]}"
    sync_files "$src_1" "$src_2"
done

cd "$DIR1" || exit
git ad
git ct "Automated backup on $(date +%y.%m.%d-%H:%M:%S)"
git u

echo "Backup complete and pushed to GitHub."

# ====================================================================================================
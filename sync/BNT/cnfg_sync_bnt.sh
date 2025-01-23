#!/bin/bash

# Directories
DIR01="$HOME/cnfg.bak"
DIR02="$DIR01/sync"
DIR03="$DIR02/BNT"
DIR04="$DIR02/cmmn"
DIR05="$DIR04/git"
DIR06="$HOME/.config/git"
# DIR07="$DIR01/fstb"
# DIR08="/etc"
# DIR09="$DIR1/crtb"
# DIR10="/var/spool/cron/crontabs"

# File pairs for syncing
declare -A files=(
    ["$DIR03/.bash_aliases"]="$HOME/.bash_aliases"
    ["$DIR03/.bashrc"]="$HOME/.bashrc"
    ["$DIR04/.inputrc"]="$HOME/.inputrc"
    ["$DIR04/.dircolors"]="$HOME/.dircolors"
    ["$DIR05/config"]="$DIR06/config"
    ["$DIR05/ignore"]="$DIR06/ignore"
    ["$DIR07/fstab.P5550#2"]="$DIR08/fstab"
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

cd "$DIR01" || exit
git ad
git ct "Automated backup on $(date +%y.%m.%d-%H:%M:%S)"
git u

echo "Backup complete and pushed to GitHub."

# ====================================================================================================
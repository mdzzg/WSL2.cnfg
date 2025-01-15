#!/bin/bash

# Directories
DIR1="$HOME/cnfg.bak"
DIR2="$DIR1/sync"
DIR3="$DIR2/BNT"
DIR4="$DIR2/git"
DIR5="$HOME/.config/git"

# File pairs for syncing
declare -A files=(
    ["$DIR3/.bash_aliases"]="$HOME/.bash_aliases"
    ["$DIR3/.bashrc"]="$HOME/.bashrc"
    ["$DIR3/.inputrc"]="$HOME/.inputrc"
    ["$DIR4/config"]="$DIR5/config"
    ["$DIR4/ignore"]="$DIR5/ignore"
)

# Function to synchronize files
sync_files() {
    local src="$1"
    local dst="$2"

    # Sync src to dest only if src is newer
    if [ "$src" -nt "$dst" ]; then
        echo "The $src is newer than the $dst"
        echo "Copying $src -> $dst"
        rsync -auv "$src" "$dst"
    elif [ "$src" -ot "$dst" ]; then
        echo "The $dst is newer than the $src"
        echo "Copying $dst -> $src"
        rsync -auv "$dst" "$src"
    else
        echo "Both files are in sync: $src and $dst"
    fi
}

# Loop over file pairs to sync them
for src in "${!files[@]}"; do
    dst="${files[$src]}"
    sync_files "$src" "$dst"
done

cd "$DIR1" || exit
git ad
git ct "Automated backup on $(date +%y.%m.%d-%H:%M:%S)"
git u

echo "Backup complete and pushed to GitHub."

# ====================================================================================================
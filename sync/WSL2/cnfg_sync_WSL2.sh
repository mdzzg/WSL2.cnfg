#!/bin/bash

# Directories
DIR01="$HOME/cnfg.bak"
DIR02="$DIR01/sync"
DIR03="$DIR02/WSL2"
DIR04="$DIR02/cmmn"
DIR05="$DIR04/git"
DIR06="$HOME/.config/git"

# File pairs for syncing
declare -A files=(
    ["$DIR03/.bash_aliases"]="$HOME/.bash_aliases"
    ["$DIR03/.bashrc"]="$HOME/.bashrc"
    ["$DIR04/.inputrc"]="$HOME/.inputrc"
    ["$DIR04/.dircolors"]="$HOME/.dircolors"
    ["$DIR05/config"]="$DIR06/config"
    ["$DIR05/ignore"]="$DIR06/ignore"
)

# Function to synchronize files
sync_files() {
    local src_1="$1"
    local src_2="$2"

    # Sync src to dest only if src is newer
    if [ "$src_1" -nt "$src_2" ] && cmp -s "$src_1" "$src_2"; then
        echo "The $src_1 is newer than the $src_2"
        echo "Copying $src_1 -> $src_2"
        rsync -auv "$src_1" "$src_2"
    elif [ "$src_1" -ot "$src_2" ] && cmp -s "$src_1" "$src_2"; then
        echo "The $src_2 is newer than the $src_1"
        echo "Copying $src_2 -> $src_1"
        rsync -auv "$src_2" "$src_1"
#	touch -r "$src_1" "$src_2"
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

# echo "Backup complete and pushed to GitHub."

# ====================================================================================================

# DIR1="$HOME/cnfg.bak"
# DIR2="$HOME/.config/git"
# DIR3="$DIR1/git"

# if [ "$DIR1/.bash_aliases_WSL2" -nt "$HOME/.bash_aliases" ]; then
#     cp -u "$DIR1/.bash_aliases_WSL2" "$HOME/.bash_aliases"
# else
#     cp -u "$HOME/.bash_aliases" "$DIR1/.bash_aliases_WSL2"
# fi

# if [ "$DIR1/.bashrc_WSL2" -nt "$HOME/.bashrc" ]; then
#     cp -u "$DIR1/.bashrc_WSL2" "$HOME/.bashrc"
# else
#     cp -u "$HOME/.bashrc" "$DIR1/.bashrc_WSL2"
# fi

# if [ "$DIR3/config" -nt "$DIR2/config" ]; then
#     cp -u "$DIR3/config" "$DIR2/config"
# else
#     cp -u "$DIR2/config" "$DIR3/config"
# fi

# if [ "$DIR3/ignore" -nt "$DIR2/ignore" ]; then
#     cp -uv "$DIR3/ignore" "$DIR2/ignore"
# else
#     cp -uv "$DIR2/ignore" "$DIR3/ignore"
# fi

# echo "Backup complete"

# ====================================================================================================

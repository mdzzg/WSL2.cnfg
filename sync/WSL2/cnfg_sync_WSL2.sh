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

# #!/bin/bash

# Directories
DIR1="$HOME/cnfg.bak"
DIR2="$DIR1/sync"
DIR3="$DIR2/WSL2"
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

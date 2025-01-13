# #!/bin/bash

# if [ ~/cnfg.bak/.bash_aliases_WSL2 -nt ~/.bash_aliases ]; then
#     cp -u ~/cnfg.bak/.bash_aliases_bnt ~/.bash_aliases
# else
#     cp -u ~/.bash_aliases ~/cnfg.bak/.bash_aliases_bnt
# fi

# if [ ~/cnfg.bak/.bashrc_WSL2 -nt ~/.bashrc ]; then
#     cp -u ~/cnfg.bak/.bashrc_bnt ~/.bashrc
# else
#     cp -u ~/.bashrc ~/cnfg.bak/.bashrc_bnt
# fi

# if [ ~/cnfg.bak/git/config -nt ~/.config/git/config ]; then
#     cp -u ~/cnfg.bak/git/config ~/.config/git/config
# else
#     cp -u ~/.config/git/config ~/cnfg.bak/git/config
# fi

# if [ ~/cnfg.bak/git/ignore -nt ~/.config/git/ignore ]; then
#     cp -u ~/cnfg.bak/git/ignore ~/.config/git/ignore
# else
#     cp -u ~/.config/git/ignore ~/cnfg.bak/git/ignore
# fi

# echo "Backup complete"

# # ====================================================================================================

# #!/bin/bash

# # Directories
# DIR1="$HOME/cnfg.bak"
# DIR2="$HOME/cnfg.bak/git"
# DIR3="$HOME/.config/git"

# # Function to synchronize files
# sync_files() {
#     local src="$1"
#     local dest="$2"

#     if [ "$src" -nt "$dest" ]; then
#         echo "Copying $src to $dest"
#         cp -u "$src" "$dest"
#     elif [ "$dest" -nt "$src" ]; then
#         echo "Copying $dest to $src"
#         cp -u "$dest" "$src"
#     else
#         echo "No changes needed for $src and $dest"
#     fi
# }

# # Ensure directories exist
# [ ! -d "$DIR1" ] && echo "Error: Directory $DIR1 does not exist" && exit 1
# [ ! -d "$DIR2" ] && echo "Error: Directory $DIR2 does not exist" && exit 1
# [ ! -d "$DIR3" ] && echo "Error: Directory $DIR3 does not exist" && exit 1

# # Synchronize files
# sync_files "$DIR1/.bash_aliases_WSL2" "$HOME/.bash_aliases"
# sync_files "$DIR1/.bashrc_WSL2" "$HOME/.bashrc"
# sync_files "$DIR2/config" "$DIR3/config"
# sync_files "$DIR2/ignore" "$DIR3/ignore"

# echo "Backup complete"

# ====================================================================================================

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
git adr
git ct "Automated backup on $(date +%y.%m.%d-%H:%M:%S)"
git u

echo "Backup complete and pushed to GitHub."

# ====================================================================================================
# #!/bin/bash

# echo "Starting file synchronization tasks..."

# # Define source and destination directories
# DOCS_SRC="/mnt/c/Users/mario/Documents"
# DOCS_DEST="/mnt/d/Lat_back"
# WSL2_SRC="/home/madz"
# WSL2_DEST="/mnt/d/WSL2"

# # Synchronize the Documents folder
# rsync -aSvEu --delete --info=progress2 --exclude="Downloaded Installations" --exclude="PTI" "$DOCS_SRC/" "$DOCS_DEST/"

# # Synchronize the WSL2 home directory
# rsync -aSvEu --delete --info=progress2 --exclude="miniforge3" --exclude=".vscode-server-insiders" --exclude="*Zone.Identifier" "$WSL2_SRC/" "$WSL2_DEST/"

# echo "File synchronization tasks completed."

# ==============================================================================================================================================

#!/bin/bash

echo "Starting file synchronization tasks..."

# Source directories
SRC1="$HOME/Documents/strucno/"
SRC2="$HOME/Documents/privatno/"

# Target directories on the \\tsclient\D drive
DEST1="/mnt/tsclient/D/strucno/"
DEST2="/mnt/tsclient/D/privatno/"

# Common rsync options
OPTIONS="-auES --delete --info=progress2 --timeout=5"

# Sync command for SRC1 to DEST1
echo "Synchronizing $SRC1 to $DEST1"
rsync $OPTIONS "$SRC1" "$DEST1"

# Sync command for SRC2 to DEST2
echo "Synchronizing $SRC2 to $DEST2"
rsync $OPTIONS "$SRC2" "$DEST2"

echo "File synchronization tasks completed."

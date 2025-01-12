#!/bin/bash

echo "Starting file synchronization tasks..."

# Define source and destination directories
DOCS_SRC="/mnt/c/Users/mario/Documents"
DOCS_DEST="/mnt/d/Lat_back"
WSL2_SRC="/home/madz"
WSL2_DEST="/mnt/d/WSL2"

# Synchronize the Documents folder
rsync -aSvEu --delete --info=progress2 --exclude="Downloaded Installations" --exclude="PTI" "$DOCS_SRC/" "$DOCS_DEST/"

# Synchronize the WSL2 home directory
rsync -aSvEu --delete --info=progress2 --exclude="miniforge3" --exclude=".vscode-server-insiders" --exclude="*Zone.Identifier" "$WSL2_SRC/" "$WSL2_DEST/"

echo "File synchronization tasks completed."
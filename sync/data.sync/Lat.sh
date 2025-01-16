#!/bin/bash

echo "Starting file synchronization tasks..."

# Define source and destination directories
DOCS_SRC="/mnt/c/Users/mario/Documents"
WSL2_SRC="/home/madz"

# Target directories on the D drive 
DOCS_DEST="/mnt/d/Lat_back"
WSL2_DEST="/mnt/d/WSL2"

# Common rsync options
OPTIONS="-auES --delete --info=progress2 --timeout=5"

# Synchronize the Documents folder
rsync $OPTIONS --exclude="Downloaded Installations" --exclude="PTI" "$DOCS_SRC/" "$DOCS_DEST/"

# Synchronize the WSL2 home directory
rsync $OPTIONS --exclude="miniforge3" --exclude=".vscode-server-insiders" --exclude="*Zone.Identifier" "$WSL2_SRC/" "$WSL2_DEST/"

echo "File synchronization tasks completed."
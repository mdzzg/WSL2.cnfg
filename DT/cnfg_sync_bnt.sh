#!/bin/bash

if [ ~/cnfg.bak/.bash_aliases_WSL2 -nt ~/.bash_aliases ]; then
    cp -u ~/cnfg.bak/.bash_aliases_bnt ~/.bash_aliases
else
    cp -u ~/.bash_aliases ~/cnfg.bak/.bash_aliases_bnt
fi

if [ ~/cnfg.bak/.bashrc_WSL2 -nt ~/.bashrc ]; then
    cp -u ~/cnfg.bak/.bashrc_bnt ~/.bashrc
else
    cp -u ~/.bashrc ~/cnfg.bak/.bashrc_bnt
fi

if [ ~/cnfg.bak/git/config -nt ~/.config/git/config ]; then
    cp -u ~/cnfg.bak/git/config ~/.config/git/config
else
    cp -u ~/.config/git/config ~/cnfg.bak/git/config
fi

if [ ~/cnfg.bak/git/ignore -nt ~/.config/git/ignore ]; then
    cp -u ~/cnfg.bak/git/ignore ~/.config/git/ignore
else
    cp -u ~/.config/git/ignore ~/cnfg.bak/git/ignore
fi

echo "Backup complete"
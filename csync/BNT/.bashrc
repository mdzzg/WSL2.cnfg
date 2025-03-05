#  __  __  _____
# |  \/  ||  __ \       
# | \  / || |  | |      mdamarija@gmail.com (mdzzg)
# | |\/| || |  | |      https://github.com/mdzzg 
# | |  | || |__| |      
# |_|  |_||_____/       
 
# My Brian Fox Bourne Again SHell runtime configuration/resource configuration/run commands.

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

### EXPORT  ###
# no duplicate entries, no entry with leading space == ignorespace & ignoredups - don't put duplicate lines or lines starting with space into the history
# alternative:
export HISTCONTROL=ignoreboth:erasedups           
export HISTTIMEFORMAT=' %y/%m/%d '	# save timestamp beside history entry
export HISTIGNORE='&:history:ls:[bf]g:exit:pwd:clear:cls:mount:umount:forget*:[ ]*'
# export TERM='xterm-256color'                      # getting proper colors

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Immediately append to the history file, do not wait until the shell exits to append it.
# See bash(1) for more options
PROMPT_COMMAND='history -a'

# append to the history file, don't overwrite history file
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=-1 #infinite history
export HISTFILESIZE=-1 #infinite history

shopt -s expand_aliases # Expand aliases for scripts and function declarations

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

### Derek Taylor SHOPT configuration
shopt -s autocd         # Automatically change to the named directory
# shopt -s cdable_vars    # Use the cd command with the names of variables that contain directory paths instead of only using literal directory paths.
shopt -s cdspell        # Autocorrects typos in the `cd` command
# shopt -s cmdhist        # save multi-line commands in history as single line
shopt -s dotglob        # Include hidden files (dotfiles) for wildcard expansion: file wildcard (* or ?) includes dotfiles - normally excluded

### myown SHOPT configuration
shopt -s checkhash      # Automatically checks and updates the hash table of commands when their location changes | Example: Useful for ensuring commands like python point to updated binaries after installation or relocation.
shopt -s direxpand      # Expands ~ or .. into full directory paths when using Tab completion
shopt -s failglob       # If a wildcard pattern does not match any files, an error message will be printed
shopt -s extglob        # extended pattern matching
shopt -s globstar       # Enables the ** wildcard pattern to match all files in nested directories
shopt -s histreedit     # Allows the user to re-edit a failed recalled history line
shopt -s histverify     # Allow the user to edit a recalled history line before executing
shopt -s nocaseglob     # Makes wildcard patterns case-insensitive


# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
# shopt -s globstar

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
# force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# parse_git_branch() {
#     git rev-parse --abbrev-ref HEAD 2>/dev/null | sed -e 's/.*/(&)/'
# }
parse_git_status() {
    # Check if inside a Git repo
    git rev-parse --is-inside-work-tree &>/dev/null || return

    # Get branch name
    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

    # Get status
    local status=$(git status --porcelain 2>/dev/null)

    local indicators=""

    # File status indicators
    [[ "$status" == *" M "* || "$status" == "M "* ]] && indicators+="*"  # Modified files
    [[ "$status" == *"?? "* ]] && indicators+="!"  # Untracked files
    [[ "$status" == *"A "* || "$status" == *"D "* || "$status" == *"R "* ]] && indicators+="+"  # Staged files
    [[ "$status" == *" U "* || "$status" == *"UU "* ]] && indicators+="%"  # Merge conflicts

    # Check if there are commits that haven't been pushed
    local ahead=$(git rev-list --count @{upstream}..HEAD 2>/dev/null || echo "0")
    [[ "$ahead" -gt 0 ]] && indicators+="#"  # Unpushed commits indicator

    # Format output
    [[ -n "$indicators" ]] && echo "($branch $indicators)" || echo "($branch)"
}

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;04;31;7m\]$(parse_git_status)\[\033[0m\]\[\033[01;04;32;7m\]\W\n\[\033[0m\]\[\033[01;37m\]'
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]$(parse_git_branch)\[\033[01;34m\]\W:\n\[\033[01;32m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\[\033[03;38;05;00;48;05;160m\]$(parse_git_status)\[\033[0m\]\[\033[04;38;05;00;48;05;35m\]\W\n\[\033[0m\]\[\033[01;38;05;221m\]'
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[1;32m\]\W \D{%H:%M}\[\033[1;32m\]$(parse_git_branch)\$ '
fi
unset color_prompt force_color_prompt


### Terminal Title  ###

# Define hardware information dynamically
# export HOSTNAMECTL_INFO_1=$(hostnamectl | grep "Hardware Model" | cut -d: -f2 | xargs)
# export HOSTNAMECTL_INFO_2=$(hostnamectl | grep "Hardware Vendor" | cut -d: -f2 | xargs)

# Update PROMPT_COMMAND for dynamic terminal title
export PROMPT_COMMAND="
    current_dir=\$(basename \"\$PWD\")
    if [[ \"\$PWD\" == \"\$HOME\" ]]; then
        current_dir=\"~\"
    elif [[ \"\$PWD\" == \"\$HOME\"/* ]]; then
        current_dir=\"~/\$(basename \"\$PWD\")\"
    fi
    echo -ne \"\033]0;${USER}@${HOSTNAME} ${HOSTNAMECTL_INFO_1} ${HOSTNAMECTL_INFO_2} | \${current_dir} | $(date +"%H:%M:%S %a %b %d") | jobs = $(jobs | wc -l) | clh = ${HISTCMD}\a\"
"

# HOSTNAMECTL_INFO_1=$(hostnamectl | grep "Hardware Model" | cut -d: -f2  | xargs)
# HOSTNAMECTL_INFO_2=$(hostnamectl | grep "Hardware Vendor" | cut -d: -f2 | xargs)
# PROMPT_COMMAND='
#     current_dir=$(basename "$PWD")
#     if [[ "$PWD" == "$HOME" ]]; then
#         current_dir="~"
#     elif [[ "$PWD" == "$HOME/"* ]]; then
#         current_dir="~/$(basename "$PWD")"
#     fi
#     echo -en "\033]0;${USER}@${HOSTNAME} ${HOSTNAMECTL_INFO_1} ${HOSTNAMECTL_INFO_2} | ${current_dir} |\r\n\r\n $(date +"%H:%M:%S %a %b %d") | jobs = $(jobs | wc -l) | clh = ${HISTCMD}\a"
#     '
# case "$TERM" in
# xterm*|rxvt*)
#     HOSTNAMECTL_INFO_1=$(hostnamectl | grep "Hardware Model" | awk -F: '{print $2}' | xargs)
#     HOSTNAMECTL_INFO_2=$(hostnamectl | grep "Hardware Vendor" | awk -F: '{print $2}' | xargs)
#     PROMPT_COMMAND="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h $HOSTNAMECTL_INFO_1 $HOSTNAMECTL_INFO_2 | \w |\r\n\r\n \t \d | jobs = \j | clh = \!\a\]$PROMPT_COMMAND"
#     ;;
# *)
#     ;;
# esac

# PROMPT_COMMAND="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h | \w |\r\n\r\n \t \d | jobs = \j | clh = \!\a\]$PS1"
# case "$TERM" in
# xterm*|rxvt*)
#     PROMPT_COMMAND='
#     HOSTNAMECTL_INFO_1=$(hostnamectl | grep "Hardware Model" | cut -d: -f2  | xargs)
#     HOSTNAMECTL_INFO_2=$(hostnamectl | grep "Hardware Vendor" | cut -d: -f2 | xargs)
#     echo -ne "\033]0;${debian_chroot:+($debian_chroot)}\u@\h $HOSTNAMECTL_INFO_1 $HOSTNAMECTL_INFO_2 | \w |\t | \d$PROMPT_COMMAND\007"'
#     ;;
# esac

# Update PROMPT_COMMAND for dynamic terminal title
# case "$TERM" in
# xterm*|rxvt*)
#     HOSTNAMECTL_INFO_1=$(hostnamectl | grep "Hardware Model" | cut -d: -f2  | xargs)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h | \w |\r\n\r\n \t \d | jobs = \j | clh = \!\a\]$PS1"
#     ;;
# *)
#     ;;
# esac

# enable color support of ls and also add handy aliases - load dircolors
# Executes the dircolors command with the -b option to generate shell commands in a format compatible with the BASH shell,
# applying the color definitions from ~/.dircolors to the current shell.
eval "$(dircolors -b ~/.dircolors)"

# colored GCC warnings and errors
export GCC_COLORS='error=01;21;31;40:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export ANDROID_SERIAL="192.168.43.203:"
# export ANDROID_SERIAL="${ANDROID_SERIAL}:55555"
# adb connect $ANDROID_SERIAL

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/madz/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/madz/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/madz/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/madz/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/madz/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/home/madz/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<
mamba deactivate

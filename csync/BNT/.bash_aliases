#  __  __  _____
# |  \/  ||  __ \       
# | \  / || |  | |      mdamarija@gmail.com (mdzzg)
# | |\/| || |  | |      https://github.com/mdzzg 
# | |  | || |__| |      
# |_|  |_||_____/       
 
# My runtime environment pseudonyms.

### PSEUDONYMS ###

# list all pseudonyms
alias ali='alias -p'

# navigation
# cd -/cd -- -> go to the previous dir -> officially retired given the up function
# alias .1=..
# alias .2=../..
# alias .3=../../..
# alias .4=../../../..
# alias .5=../../../../..

###	alias for the most used commands	###

alias cnfg=~/cnfg.bak
alias cv=~/Documents/data/job.applications/cv/tex.v4.6
alias cla=~/Documents/data/job.applications/personal.letter/novo.academia/generic.application
alias cli=~/Documents/data/job.applications/personal.letter/novo.industry/generic.application/cl_ind_gen
alias dc=~/Documents
alias dl=~/Downloads

###     ls    ###
# export LS_COLORS="no=01;32;40:di=01;36;40:fi=01;04;97:ex=01;04;31:ow=92;100:*.tex=01;04;31:*.pdf=01;04;35:"\
# "*.py=01;04;32:*.sh=01;04;32:*.tar.gz=01;04;32:*html=01;04;33:*css=01;04;33:*js=01;04;33:*json=01;04;33:*xml=01;04;33:*md=01;04;33:*txt=01;04;33:*csv=01;04;33:*dat=01;04;33:*log=01;04;33:*bak=01;04;33:*tar=01;04;33:*zip=01;04;33:*rar=01;04;33:*7z=01;04;33:*deb=01;04;33:*bin=01;04;33:*iso=01;04;33:*img=01;04;33:*mp3=01;04;33:*mp4=01;04;33:*mkv=01;04;33:*avi=01;04;33:*mov=01;04;33:*wmv=01;04;33:*flv=01;04;33:*webm=01;04;33:*gif=01;04;33:*jpg=01;04;33:*png=01;04;33:*bmp=01;04;33:*svg=01;04;33:*tiff=01;04;33:*eps=01;04;33:*ps=01;04;33:*odt=01;04;33:*doc=01;04;33:*docx=01;04;33:*xls=01;04;33:*xlsx=01;04;33:*ppt=01;04;33:*pptx=01;04;33:*odp=01;04;33:*rtf=01;04"
alias ll='ls -AFghoX --hyperlink=auto --color=always'  # F - classify executables (*), directories (/), symbolic links (@); X - alphabetical sort; A - all WO parents; og - omit owner & group;
alias lc='ls -CFhm ---hyperlink=auto -color=always'    # C - column mode; m - comma separated
# R - recursive display of all dirs
alias dir='dir --hyperlink=auto --color=always'
alias vdir='vdir --hyperlink=auto --color=always'
alias nfnd='find . -type f ! -path "./.git/*"'  # ! -name '*.png'    all files in the current directory except for the .git directory
alias nls='ll -d !('.git')'  # list all files in the current directory except for the .git directory
alias tr='tree -aC -L 2 --dirsfirst --noreport'  # -a - all files; -C - colorize; -L 2 - depth 2; --dirsfirst - list directories first; --noreport - no summary; --hyperlink=auto - hyperlink files; --color=always - colorize output

###     grep    ###
export GREP_COLORS="ms=01;04;33:mc=01;32;7:sl=01;37:cx=33:fn=01;33:ln=32:bn=34:se=36"
alias grep='grep --color=always --group-separator=SEP'
alias fgrep='grep -F --color=always'    # Interpret PATTERNS as fixed strings (F).
alias egrep='grep -E --color=always'    # Interpret PATTERNS as extended regular expressions (EREs, see below).
alias diff='diff --color=always'
alias sdiff='sdiff -s'

###	apt/snap	###
alias list_apt="apt list --installed|cut -d/ -f1|grep -v Listing...|nl|most"
alias list_apts="apt list --installed 2>/dev/null | sed -n 's,/.*,,p'|egrep -nv '^(python|lib)'|nl"
# alias list_apt="apt list --installed|awk -F '/' '/^/ {print $1}'|cut -f1|grep -v Listing...|nl|most"	# inflated compared to the above
# alias list_apt="apt list --installed 2>/dev/null | sed -n 's,/.*,,p'|nl|most"
alias list_full='compgen -c|sort -u|nl|most'
alias list_descriptive='whatis `compgen -c`|sort -u|nl|most'
alias update='sudo apt update -y && sudo apt full-upgrade -y'
alias clean='sudo apt purge -y && sudo apt autoclean -y && sudo apt autoremove -y'
alias snaprf='sudo snap refresh'
alias snapi='sudo snap install'
alias snaprm='sudo snap remove'
alias snapl='snap list'
# alias upgradable="apt list --upgradable|awk -F '/' '/^/ {print $1}'|cut -f1|grep -v Listing...|tr '\r\n' ' '"
# apt list --upgradable|awk -F '/' '/^/ { print $1 }'
# apt list --installed|awk -F '/' '/^/ { print $1 }'
# apt-cache show %packagename
# apt-cache search %packagename |sort

### CRON ###
alias crons='service cron status'
alias cronr='sudo service cron restart' # Stops and then starts the cron service. This terminates all currently running jobs and restarts the scheduler. Use it for a hard reset when something seems wrong with the service.

# alias cronfr='sudo service cron force-reload' # Forces the cron service to re-read its configuration files (e.g., /etc/crontab or ~/.crontab), even if there's no detected change. Use it when configuration changes were made but didn't take effect.

# alias cronfr='sudo service cron reload' # Gracefully reloads the configuration of the cron service. This is often equivalent to a light restart but does not terminate active jobs. Use when you want to refresh cron configurations without disrupting currently running tasks.

# ps
alias psa='ps auxf'          # process status of all running processes - tree view
alias psgrep='ps aux|grep -v grep|grep -i VSZ'
alias psmem='ps auxf|sort -nr -k 4'
alias pscpu='ps auxf|sort -nr -k 3'

### system  ###
alias var='env|most'

###	turn off	###
alias off='systemctl poweroff --now'
alias reboot='systemctl reboot -i'
alias soff='sudo systemctl poweroff --now'
alias hoff='systemctl hibernate'
#	sudo systemctl reboot --firmware-setup

###	latex/pdf	##
alias txfy='pdflatex -output-directory=bin' # -jobname=filename -output-directory=bin -aux-directory=bin
alias pdf2txt='pdftotext'

### git ###
alias gt='git'
alias gcnfg='gt cnfg|fgrep alias|sort'
#alias graph='git log --oneline --decorate --all --graph'

###	frequent	###
alias rst='. ~/.bashrc'	#'source ~/.bashrc'
alias rsti='bind -f ~/.inputrc'	#'source ~/.bashrc'
alias cls="printf '\033c'"
alias alt='sudo update-alternatives --config' 
#alias forget='1
alias line="printf '\033[1;31m%100s\033[0m\\n' | tr ' ' ="
# alias hline="printf '%100s\n' | tr ' ' \#"
# alias mline="printf '%125s\n' | tr ' ' --"

###	RAM	###
alias free='free -m'           # show sizes in MB
alias RAM0='sudo lshw -c memory'
alias RAM1='sudo dmidecode --type memory'
alias RAM2='sudo dmidecode -t 17'

###	battery		###
alias power='upower -i /org/freedesktop/UPower/devices/battery_BAT0|grep -e 'state:' -e 'percentage:''
# alias charge='acpi'
# smbios-battery-ctl --get-charging-cfg
# smbios-battery-ctl --set-charging-mode=custom
# smbios-battery-ctl --set-custom-charge-interval=50 80	#	it has to be integer value

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

###	rsync	###
alias csync='~/cnfg.bak/csync/BNT/cnfg_sync_bnt.sh'
alias clone='dd if=/dev/sda1 of=/dev/sdb1 bs=64k status=progress conv=fdatasync,noerror,sync'
# block size 64k, reliable copy, compared to larger block sizes; fdatasync - flushes data to disk for integrity, ensures that all written data reaches the physical disk before dd exits; noerror - continues on read errors; prevents the process from stopping when a read error occurs but does not handle skipped blocks; sync	- pads blocks with nulls for alignment; works with noerror to ensure skipped blocks are filled with null bytes, maintaining the correct output size.

#	rsync -OaEHv --delete --info=progress2 /mnt/nfs/149.1gsb/ /mnt/nfs/465.8gwdcg/data/ # a==rlptgoD - it does not include preserving ACLs (-A), xattrs (-X), atimes (-U), crtimes (-N), nor the finding and preserving of hardlinks (-H); H==preserve hardlinks; E==preserve executability x of files; v==verbose;
#	rsync -aSvx . tv-box.local:/home/madz/Videos    # S==Try to handle sparse files efficiently so they take up less space on the destination; x==one-file-system; a==archive mode; v==verbose
#	rsync -aSvE --delete --info=progress2 /mnt/nfs/149.1gsb/ /mnt/nfs/465.8gwdcg/data/ # a==rlptgoD - it does not include preserving ACLs (-A), xattrs (-X), atimes (-U), crtimes (-N), nor the finding and preserving of hardlinks (-H); S==Try to handle sparse files efficiently so they take up less space on the destination; v==verbose;

###	python: adding jupyter to the environment	###
#	pip install ipykernel
#	python -m ipykernel install --user --name env.name --display-name 'esm-2024'

###	python		###
#   alias ipy3="ipython3 --no-confirm-exit --no-banner --quick --InteractiveShellApp.extensions=\"['autoreload']\" --InteractiveShellApp.exec_lines=\"['%autoreload 2', 'import os,sys,%alias']\""

###	exportfs	###
#	screen sudo gedit /etc/exports
#	sudo exportfs -rv && sudo systemctl restart nfs-kernel-server
#	sudo exportfs -a
#	sudo exportfs -s
#	sudo exportfs -fv

###	chown & chmod	###
#	sudo chmod 0777 /etc/exports
#	sudo chown mdzzg:mdzzg /etc/fstab
#	sudo chown nobody:nogroup /mnt/nfs/149.1gsb/backup/data.backup/cl.history/.bash_history
#	sudo chmod -R 0777 /mnt/nfs/149.1gsb/backup/data.backup/cl.history/.bash_history
#	sudo chown -R nobody:nogroup /mnt/nfs && sudo chmod -R 0777 /mnt/nfs
#	sudo chown -hR madz /mnt

###	mounts	###
alias disk='df -h'          # human-readable sizes
# alias smount='showmount -e 8560w.local'
# alias mountn='sudo mount -t nfs 8560w.local:/mnt/nfs /mnt/nfs'
# alias umounta='sudo umount -a'
# alias spec='sudo smartctl -i'
# sudo blkid
# lsblk

###	variuos	###
alias clc='bc' ### scale=2
alias PWD='LANG=c < /dev/urandom tr -dc _A-Z-a-z-0-9|head -c$"16";echo;'
# alias clc='ncal -b' ### scale=2

### speedtest   ###
alias spdtst='speedtest-cli --bytes --simple' #  --list ->  Display a list of speedtest.net servers sorted by distance
# alias spdtst='speedtest -v -P 8 -u MiB/s'

###    FUNCTIONS	###

# function that queries apt for upgradable packages, lists them, & then installs them
function upgradable() { echo $(apt list --upgradable 2>&1|egrep -v 'Listing...|apt does not have a stable CLI interface'|cut -d/ -f1|awk '{$1=$1};1'|tr '\r\n' ' ');}
export -f upgradable

function upgrade(){ sudo apt install $(apt list --upgradable 2>&1|awk -F '/' '/^/ {print $1}'|cut -f1|egrep -v 'Listing...|apt does not have a stable CLI interface'|sed 's/^[[:space:]]*//'|tr '\r\n' ' ') -y;}
export -f upgrade

# function that lists installed apt/dpkg packages
list_dpkg(){
    # dpkg-query -W -f='${Package}\n' | less
    dpkg -l|awk '/^ii/ {print $2}'|nl|most;
}
export -f list_dpkg

###     git     ###

function gt-filter(){ gt filter-repo --invert-paths --path '$1';}
export -f gt-filter

function gt-filtera(){ gt filter-repo --invert-paths --all --path '$1';}
export -f gt-filtera

function gt-filtert(){ gt filter-repo --replace-text '$1';}
export -f gt-filtert

function gt-filtertf(){ gt filter-repo --force --replace-text '$1';}
export -f gt-filtertf

function gt-radd(){ gt remote add "$1" "$2";}
export -f gt-radd

function gt-init(){ gt u --set-upstream "$1" "$2";}   # git init & set upstream repo for the branch: `-u` == `--set-upstream`
export -f gt-init

function gt-branch-delete(){ gt br -d "$1" && gt u "$2" -d "$1" && gt rt prune "$2";}
export -f gt-branch-delete

# function git-rmrm(){ gt rm -r --cached "$1";}  # removes files from git cache recursively - become untracked by Git

function gt-rtrm(){ gt remote remove "$1";}
export -f gt-rtrm

function gt-prune(){ gt remote prune "$1";}   # cleans git cache from previously removed branches
export -f gt-prune

function gt-branch-rename(){ gt branch -m "$1" "$2" && gt push "$3" -d "$1" && gt push "$3" "$2";}
export -f gt-branch-rename

function gt-branch-create(){ gt checkout -b "$1" && gt push -u "$2" "$1";}
export -f gt-branch-create

function gt-branch-merge(){ gt checkout "$1" && gt merge "$2";}
export -f gt-branch-merge

function crlf2lf(){ 
    find . -type f ! -path "./.git/*" ! -name "*.png" | while IFS= read -r file; do
    sed -i 's/\r$//' "$file"
    done
}
export -f crlf2lf
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

###     cd up    ###

function up() {
    local d=""
    local limit="$1"

    if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
        limit=1
    fi

    for ((i=1;i<=limit;i++)); do
        d="../$d"
    done

    # if ! cd "$d"; then
    #     echo "couldn't go up $limit dirs.";
    # fi
    
    # Change to the constructed path
    cd "$d" || return
}
export -f up

###     process kill    ###
function pss(){ ps aux|grep snap|awk '{print $2}'|sudo xargs kill -9;}
export -f pss

function psb(){ ps aux|grep brave|awk '{print $2}'|sudo xargs kill -9;}
export -f psb

# function that checks for broken URLs in a resume.pdf
function pdfcheck(){ pdfx -v bin/"$1" -c;}
export -f pdfcheck

###     mkdir creates parents verbosely and cds into it immediatelly    ###
function mcd() {
    /bin/mkdir -pv "$1" && cd "$1"
}
export -f mcd

###     find    ###

###    find files and directories arbitrary depth   ###
function ff() { find . -depth -type f -name "*$1*";}
export -f ff

function fd() {	find . -depth -type d -name "*$1*";}
export -f fd

#	find ~/ -type f -name "postgis-2.0.0"
#	pdfgrep -ri python /home/madz/Dropbox/
#	find /path -iname '*.pdf' -exec pdfgrep pattern {} +

###	work    ###
# alias pss34='/mnt/c/Program\ Files\ \(x86\)/PTI/PSSEXplore34/PSSBIN/Psse34.exe'
# alias insiders='/mnt/c/Users/mario/AppData/Local/Programs/Microsoft\ VS\ Code\ Insiders/Code\ -\ Insiders.exe'

# function insiders(){
# /mnt/c/Users/mario/AppData/Local/Programs/Microsoft\ VS\ Code\ Insiders/Code\ -\ Insiders.exe "$1"
# }

###	retired	###
#	alias eno1='sudo ifdown wlp2s0 && sudo ifup eno1'
#	alias wlp2s0='sudo ifdown eno1 && sudo ifup wlp2s0'
#	alias mounta='sudo mount /dev/sda /media/madz/298.1G/; sudo mount /dev/sdb /media/madz/149.1G/; sudo mount /dev/sdd /media/madz/465.8G/ || sudo mount /dev/sdc /media/madz/465.8G/'
#	alias umounta='sudo umount /dev/sda; sudo umount /dev/sdb; sudo umount /dev/sdd || sudo umount /dev/sdc'
#	function mycvcl() { cvlc $1 && wmctrl -r :ACTIVE: -b toggle,above; }
#	alias yt='youtube-dl'
#	alias yta='youtube-dl -x -f bestaudio/best'
#	alias ytva='youtube-dl -f bestvideo,bestaudio'
#	alias playlist='%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'

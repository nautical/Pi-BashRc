HISTCONTROL=ignorespace
echo 'export PATH=$PATH:/usr/local/bin:/usr/local/netbeans-7.2/bin/'
clear
PS1='\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[0;31m\]\$ \[\e[m\]\[\e[0;32m\]'
echo "============NAUTICAL================"
echo
#alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias h='history'
alias j='jobs -l'
alias which='type -a'
alias ..='cd ..'
alias .='ls'
alias path='echo -e ${PATH//:/\\n}'
alias du='du -kh'       # Makes a more readable output.
alias df='df -kTh'
alias ll="ls -l --group-directories-first"
alias ls='ls -hF --color'  # add colors for filetype recognition
alias la='ls -Al'          # show hidden files
alias lx='ls -lXB'         # sort by extension
alias lk='ls -lSr'         # sort by size, biggest last
alias lc='ls -ltcr'        # sort by and show change time, most recent last
alias lu='ls -ltur'        # sort by and show access time, most recent last
alias lt='ls -ltr'         # sort by date, most recent last
alias lm='ls -al |more'    # pipe through 'more'
alias lr='ls -lR'          # recursive ls
alias tree='tree -Csu'     # nice alternative to 'recursive ls'
alias meminfo='cat /proc/meminfo'
alias hg='/usr/local/bin/hg'
alias map='cat /proc/self/maps'
alias clock='clear;while true;do tput clear;date +"%r";sleep 1;done'
# start bash with -T "heading string" to diff
alias editbash='vim ~/.bashrc'
alias downloads="cd /root/Desktop-1/Bench/sources"
alias cap="tcpdump > cap &"
alias updatetime="ntpdate -u ntp1.vrlsoftwaresolutions.in" # Indian server configure your own 

function updategit(){
    cd /root/Desktop/source/esControl/
    ./update.sh "$@"  # Check out update-git repo
}


alias xs='cd'
alias vf='cd'
alias moer='more'
alias moew='more'
alias kk='ll'

function ff() { find . -type f -iname '*'$*'*' -ls ; }

# Find a file with pattern $1 in name and Execute $2 on it:
function fe()
{ find . -type f -iname '*'${1:-}'*' -exec ${2:-file} {} \;  ; }

function findin()
{
grep -r 

}

function extract()
{
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xvjf $1     ;;
             *.tar.gz)    tar xvzf $1     ;;
             *.bz2)       bunzip2 $1      ;;
             *.rar)       unrar x $1      ;;
             *.gz)        gunzip $1       ;;
             *.tar)       tar xvf $1      ;;
             *.tbz2)      tar xvjf $1     ;;
             *.tgz)       tar xvzf $1     ;;
             *.zip)       /usr/local/bin/unzip $1        ;;
             *.Z)         uncompress $1   ;;
             *.7z)        7z x $1         ;;
	     *.xz)	  tar -xvf $1	;;
             *)           echo "Nautical careful !! no need to hurry up" ;;
         esac
     else
         echo "'$1' is not a valid file :_( .. snob snob .. "
     fi
}

function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }
function pp() { my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }


function killps()                 # Kill by process name.
{
    local pid pname sig="-TERM"   # Default signal.
    if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
        echo "Usage: killps [-SIGNAL] pattern"
        return;
    fi
    if [ $# = 2 ]; then sig=$1 ; fi
    for pid in $(my_ps| awk '!/awk/ && $0~pat { print $1 }' pat=${!#} ) ; do
        pname=$(my_ps | awk '$1~var { print $5 }' var=$pid )
        if ask "Kill process $pid <$pname> with signal $sig?"
            then kill $sig $pid
        fi
    done
}

function ii()   # Get current host related info.
{
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Memory stats :$NC " ; free
    my_ip 2>&- ;
    echo -e "\n${RED}Local IP Address :$NC" ; echo ${MY_IP:-"Not connected"}
    echo -e "\n${RED}ISP Address :$NC" ; echo ${MY_ISP:-"Not connected"}
    echo -e "\n${RED}Open connections :$NC "; netstat -pan --inet;
    echo
}

function nautical()
{
    echo "ff : find a file with a pattern in name"
    echo "fe : Find a file with pattern $1 in name and Execute $2 on it:"
    echo "fstr: Find a pattern in a set of files and highlight them"
    echo "extract: need details ??"
    echo "my_ps: my running process"
    echo "pp: "
    echo "killps: kill process by name"
    echo "ii: hostinfo"
}

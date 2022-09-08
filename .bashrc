source /etc/profile

export EDITOR=vim
#export LANG=ru_RU.UTF8
export LANG=en_US.UTF8
#export LC_ALL=en_US.UTF8

export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)
export GROFF_NO_SGR=1         # For Konsole and Gnome-terminal
export MANWIDTH=80
export LESS="-i -R -x4 -F -X -J --line-num-width=4 -N"

export HISTFILESIZE=100000
export HISTSIZE=10000
export HISTCONTORL=ignoredups

export DISTCC_DIR=/tmp/distcc
export DISTCC_HOSTS="distcc.local/24"

stty stop undef
stty start undef

alias df="df -hT"
alias grep="grep --color=auto"
alias x509info="openssl x509 -noout -text -in"
alias diff='diff --color=auto'
alias ls='ls --color=auto'
alias lsblk='lsblk -o NAME,SIZE,FSTYPE,FSSIZE,FSUSED,FSAVAIL,FSUSE%,MOUNTPOINT,LABEL'
alias sshot='scrot "%Y-%m-%d_$wx$h.png" -e "mv $f ~/shots/"'
alias ssshot='scrot -s "%Y-%m-%d_$wx$h.png" -e "mv $f ~/shots/"'
alias cal='cal -my'
alias cd..='cd ..'

. /usr/share/bash-completion/bash_completion

export SDL_VIDEO_FULLSCREEN_DISPLAY=0
export SDL_VIDEO_WINDOW_POS=0,0

export MPD_HOST='yekm_mpd@localhost'

export GOPATH=$HOME/go
export PATH="~/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="~/.local/bin:$PATH"
#export PATH=/usr/lib/ccache:$PATH
#export PATH=/opt/rpi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin:$PATH

# Created by `userpath` on 2020-04-23 12:16:01
export PATH="$PATH:/home/yekm/.local/bin"
export PATH="/usr/lib/ccache/bin:$PATH"

export COLORTERM=truecolor

export SYSTEMD_DEBUGGER=cgdb

#export MC_SKIN=~/etc/solarized.ini
export MC_SKIN=yadt256-defbg

# https://unix.stackexchange.com/a/147572
bind Space:magic-space

# https://github.com/pkrumins/bash-vi-editing-mode-cheat-sheet/blob/master/bash-vi-editing-mode-cheat-sheet.txt
#set -o vi


LONGLINE="════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
# https://stackoverflow.com/a/1862762/17388074
function timer_start {
  ___timer=${___timer:-$SECONDS}
}

function timer_stop {
  timer_show=$(($SECONDS - $___timer))
  unset ___timer
}

trap 'timer_start' DEBUG
PROMPT_COMMAND='history -a; timer_stop;'

HOST='\033[02;36m\]\h'; HOST=' '$HOST
TIME='\033[01;31m\]\t \033[01;32m\]'
LOCATION=' \033[01;34m\]$PWD'
. /usr/share/git/git-prompt.sh
BRANCH=' \033[00;33m\]$(__git_ps1)\[\033[00m\]\e[?7l$LONGLINE\e[?7h\]\n\$ '
PS1="\$? \${timer_show} $TIME$USER$HOST$LOCATION$BRANCH"
PS2='\[\033[01;36m\]>'


PATH="/home/yekm/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/yekm/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/yekm/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/yekm/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/yekm/perl5"; export PERL_MM_OPT;

source /etc/profile

export EDITOR=vim
#export LANG=ru_RU.UTF8
export LANG=en_US.UTF8
export LESS="-i -R -x4 -F -X $LESS"
export HISTFILESIZE=100000
export HISTSIZE=10000
export HISTCONTORL=ignoredups

stty stop undef
stty start undef

alias df="df -hT"
alias grep="grep -n --color=auto"
alias x509info="openssl x509 -noout -text -in"
alias diff='diff --color=auto'
alias ls='ls --color=auto'
alias lsblk='lsblk -o NAME,SIZE,FSTYPE,FSSIZE,FSUSED,FSAVAIL,FSUSE%,MOUNTPOINT,LABEL'

. /usr/share/bash-completion/bash_completion

#PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

export SDL_VIDEO_FULLSCREEN_DISPLAY=0
export SDL_VIDEO_WINDOW_POS=0,0

export MPD_HOST='yekm_mpd@localhost'

export MANPAGER="/usr/bin/most -s"

export GOPATH=$HOME/go
export PATH="~/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="~/.local/bin:$PATH"
#export PATH=/usr/lib/ccache:$PATH
#export PATH=/opt/rpi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin:$PATH

export PS1="════════════════════════════════════════════════════════════════════════════════\n\t \w\n\$? \h:\u\\$ "

# Created by `userpath` on 2020-04-23 12:16:01
export PATH="$PATH:/home/yekm/.local/bin"
export PATH="/usr/lib/ccache/bin:$PATH"

export COLORTERM=truecolor


source /etc/profile
#source ~/.colors

export EDITOR=vim
#export LANG=ru_RU.UTF8
export PATH="/opt/some:$PATH"
export LESS="-i -R -x4 $LESS"
export HISTFILESIZE=100000
export HISTSIZE=10000
export HISTCONTORL=ignoredups
stty stop undef
stty start undef
[ -f ~/.aliases ] && . ~/.aliases
#export PATH=/usr/lib/ccache:$PATH
#. /etc/bash_completion

#PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

export SDL_VIDEO_FULLSCREEN_DISPLAY=0
export SDL_VIDEO_WINDOW_POS=0,0

#source ~/perl5/perlbrew/etc/bashrc

#GIT_PS1_SHOWUPSTREAM="verbose name"
#GIT_PS1_SHOWDIRTYSTATE=1
#GIT_PS1_SHOWSTASHSTATE=1
##GIT_PS1_SHOWUNTRACKEDFILES=1
#GIT_PS1_SHOWCOLORHINTS=1
#source /usr/share/git/git-prompt.sh
#PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

#export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

export MANPAGER="/usr/bin/most -s"

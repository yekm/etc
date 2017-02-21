source /etc/profile
#source ~/.colors

export EDITOR=vim
#export LANG=ru_RU.UTF8
export PATH="/opt/some:$PATH"
export PATH="~/bin:$PATH"
export LESS="-i -R $LESS"
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

export PATH=/opt/rpi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin:$PATH
export MPD_HOST='yekm_mpd@localhost'

source /etc/profile

#source ~/.colors

gitbranch()
{
    git branch 2>/dev/null | sed -ne '/*/ s/* // p'
}

if [[ ${EUID} == 0 ]] ; then
    PS1='\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
else
    PS1='$(date)   ($(gitbranch))\n\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
fi

export PS1
export EDITOR=/usr/bin/vim
export LANG=ru_RU.UTF8
export PATH="/opt/some:$PATH"
export LESS="-i -R $LESS"
export HISTFILESIZE=100000
export HISTSIZE=10000
stty stop undef
stty start undef
[ -f ~/.aliases ] && . ~/.aliases
export PATH=/usr/lib/ccache:$PATH
. /etc/bash_completion

PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'


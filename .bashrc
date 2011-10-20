source /etc/profile
export EDITOR=/usr/bin/vim
export LANG=ru_RU.UTF8
export PATH="/opt/some:$PATH"
export LESS="-i $LESS"
export HISTFILESIZE=100000
export HISTSIZE=10000
stty stop undef
stty start undef
[ -f ~/.aliases ] && . ~/.aliases
#export PATH="~/bin:/usr/lib/colorgcc/bin:${PATH}"


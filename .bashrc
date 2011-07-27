source /etc/profile
export EDITOR=/usr/bin/vim
export LANG=ru_RU.UTF8
export PATH="/opt/some:$PATH"
stty stop undef
stty start undef
[ -f ~/.aliases ] && . ~/.aliases


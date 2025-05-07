#!/usr/bin/env bash

if command -v fdfind >/dev/null 2>/dev/null
then
  alias fd=fdfind
fi

alias bc='bc -lq'
alias cal3="cal -3"
alias check="aspell check -d en_US"
alias checkNO="aspell check -d no"
alias df="df -h"
alias diffsmooth="diff --side-by-side --suppress-common-lines --ignore-trailing-space --ignore-space-change --ignore-all-space"
alias dnf="dnf -y"
alias dc="cd"
alias du="du -h"
alias ga="git add ."
alias gac="git add . && git commit -m \"\$(fortune | tr '\n' ' ')\""
alias gacp="git add . && git commit -m \"\$(fortune | tr '\n' ' ')\" && git push" # for private repos, I do not care what the commit message is
alias gcp="git commit -m \"\$(fortune | tr '\n' ' ')\" && git push" # for private repos, I do not care what the commit message is
alias gc="git commit -m \"\$(fortune | tr '\n' ' ')\""
alias gp="git push"
alias gclean='(git gc --prune=now  ; git remote prune origin) && git pull'
alias gdb="gdb --quiet"
alias gpg="gpg2"
alias gs="git status"
alias jkm='make'
alias kjm='make'
alias km='make'
alias ipy='ipython'
alias l='ls'
alias la='ls -A'
alias lear="clear"
alias ll='ls -alh'
alias ls='ls --color=auto -h'
alias lt='ls -t -r'
alias m="make"
alias mc="make clean"
alias mj='make'
alias mj='make'
alias mjk='make'
alias mk='make'
alias mkdir='mkdir'
alias mkj='make'
alias mv='mv -vi'
alias nvmi="nvim"
alias nvi="nvim"
alias nmiv="nvim"
alias no="setxkbmap no"
alias pg="ps aux | grep "
alias pirate="youtube-dl --no-playlist --extract-audio --audio-format mp3"
alias py="ipython"
alias scren='screen -T xterm'
alias screen='screen -UT xterm'
alias us="setxkbmap us"

function smallimg()
{
    convert -size 32x32 "xc:${2:-orange}" "${1:-empty.jpg}"
}

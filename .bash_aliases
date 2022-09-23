#!/usr/bin/env bash

if command -v fdfind >/dev/null 2>/dev/null
then
  alias fd=fdfind
fi

alias apt="apt -y"
alias bc='bc -lq'
alias cal3="cal -3"
alias check="aspell check -d en_US"
alias checkNO="aspell check -d no"
# alias curl=$'curl -sw "`curl -w`: HTTP %{http_code}"'
#alias curl=$'curl -sw "\n(curl -sw): %{http_code}\n"'
alias df="df -h"
alias diffsmooth="diff --side-by-side --suppress-common-lines --ignore-trailing-space --ignore-space-change --ignore-all-space"
alias dnf="dnf -y"
alias du="du -h"
alias e=": edit"
alias emerge="sudo apt install -y"
alias ga="git add ."
alias gac="git add . && git commit -m \"\$(fortune | tr '\n' ' ')\""
alias gacp="git add . && git commit -m \"\$(fortune | tr '\n' ' ')\" && git push" # for private repos, I do not care what the commit message is
alias gc="git commit -m \"\$(fortune | tr '\n' ' ')\""
alias gclean='(git gc --prune=now  ; git remote prune origin) && git pull'
alias gdb="gdb --quiet"
alias gpg="gpg2"
alias grep="grep --color=always"
alias gs="git status"
alias hindent="hindent --style johan-tibell"
alias jkm='make'
alias kjm='make'
alias km='make'
alias mutt='neomutt'
alias ipy='ipython'
alias l='ls'
alias la='ls -A'
alias lear="clear"
alias ll='ls -alh'
alias ls='ls --color=auto -h'
alias lt='ls -t -r'
alias m="make"
alias mj='make'
alias mj='make'
alias mjk='make'
alias mk='make'
alias mkdir='mkdir'
alias mkj='make'
alias mountusb='sudo mount -o umask=000'
alias mv='mv -vi'
alias nvmi="nvim"
alias nvi="nvim"
alias nmiv="nvim"
alias no="setxkbmap no"
alias nstack='nice stack'
alias paste="xclip -o && echo"
alias pg="ps aux | grep "
alias pirate="youtube-dl --no-playlist --extract-audio --audio-format mp3"
alias plantuml="plantuml -graphvizdot $(which dot)"
alias wtf="ping -c1 google.com"
alias py="ipython"
alias rmdir='rmdir'
alias scren='screen -T xterm'
alias screen='screen -T xterm'
[ -e "/etc/NIXOS" ] && alias stack='stack --nix'
alias sp=": split  "
alias stream="vlc   --sout-display-delay=30000 --sout-transcode-venc=mp4 v4l2:///dev/video0"
alias us="setxkbmap us"
alias vim="nvim"
alias vs=": vsplit"
alias wo="cd /mnt/c/msys64/home/anderss/"
alias da="cd /mnt/c/Users/anderss/data"

function smallimg()
{
    convert -size 32x32 "xc:${2:-orange}" "${1:-empty.jpg}"
}


export OTHER_COMP="169.254.244.132"
function samba()
{
    if [ ! -d "samba/${1}" ]
    then
        mkdir -vp samba/"${1}"
    fi
    GID=$(id -g "${USER}")
    sudo   mount -t cifs "//${OTHER_COMP}/${1:obteam2}" "${HOME}/samba/${1}/" -o user=asildnes,domain=SYSCOPERU,gid="${GID}",uid="${UID}"
}

alias mountVm="sudo sshfs -p 2222 -o allow_other,IdentityFile=~/.ssh/id_rsa,Ciphers=arcfour tdt4258@127.0.0.1:4258Group10 /mnt/vm/"

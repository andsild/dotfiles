#!/usr/bin/env bash
#shellcheck disable=SC1091,SC1090

# If not running interactively, don't read preferences.
[ -z "$PS1" ] && return

bind -f "${HOME}/dotfiles/.inputrc"
for file in $HOME/dotfiles/Bash/Sourced/* "${HOME}/dotfiles/.bash_aliases" ; do . "${file}"; done

export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:";
# Make `less` "color-blind" and case insensitive
export PAGER="less -Rfi"
export VAULT_ADDR='http://95.217.0.169:8200'

# Variables ##
# PS1='\u@\h: ~${PWD##*/} > '
GREEN="$(printf '%b' '\e[01;32m')"
YELLOW="$(printf '%b' '\e[00;33m')"
WHITE="$(printf '%b' '\e[00;00m')"
RED="$(printf '%b' '\e[01;31m')"
RED_SOFT="$(printf '%b' '\e[00;31m')"
BLUE="$(printf '%b' '\e[01;34m')"
TEAL="$(printf '%b' '\e[00;36m')"
PURPLE="$(printf '%b' '\e[00;35m')"
SMILEY="${GREEN}:)"
FROWNY="${RED}:("
case $(hostname) in
    antipater)
        HOSTNAME="${YELLOW}"
        ;;
    gpu3)
        HOSTNAME="${BLUE}"
        ;;
    094)
        HOSTNAME="${PURPLE}"
        ;;
    093)
        HOSTNAME="${TEAL}"
        ;;
    *)
        HOSTNAME="${WHITE}"
        ;;
esac
export SCREENDIR=${HOME}/.screen
HOSTNAME="${HOSTNAME}$(hostname)${WHITE}"
SMILEYFROWNY="if [ \$? = 0 ]; then echo \"${SMILEY}\"; else echo \"${FROWNY}\"; fi"
PS1=$(printf "%s %s\[%s\]%s@%s\[${WHITE}\]:%s\n \n" \
         "\`${SMILEYFROWNY}\`" \
	 "\`if [ \"$(whoami)\" == \"root\" ]; then echo \"${RED}\"; else echo \"${WHITE}\"; fi\`" \
         "\u" \
         "${HOSTNAME}" \
         "\w" \
)
HISTIGNORE="ls:l:clear"
PATH="${HOME}/dotfiles/Bash:${HOME}/.local/bin:${HOME}/bin/:${PATH}:/usr/local/bin/"
PROMPT_COMMAND='history -a'
export HISTCONTROL="ignoreboth"
export EDITOR="nvim"

# Disable Software Flow Control (xon) (give me back Ctrl+s and Ctrl+q)
stty -ixon

# My jedi-vim needs this(ugh!)
export IPYTHONDIR="${HOME}/.ipython"

export HISTSIZE=1000000
export HISTFILE_SIZE=1000000

shopt -s cdspell # Enable directory autocorrection

[ -f ~/.fzf.bash ] && . ~/.fzf.bash

export SCIPY_PIL_IMAGE_VIEWER="xdg-open"
export XDG_CONFIG_HOME="${HOME}/.config/" XDG_DATA_DIR="${HOME}/.local/share/" XDG_DATA_HOME="${HOME}/.local/share/" XDG_CACHE_HOME="${HOME}/.cache"
export FZF_DEFAULT_OPTS='--extended -i --exact' FZF_COMPLETION_OPTS='--extended --exact'
export FZF_DEFAULT_COMMAND='fdfind --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

_pip_completion()
{
  COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                 COMP_CWORD=$COMP_CWORD \
                 PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip

export ANSIBLE_NOCOWS=1

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/aza4423/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/aza4423/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/aza4423/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/aza4423/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

test -d "$HOME/.cargo/env" && . "$HOME/.cargo/env"

# !! Contents within this block are managed by 'conda init' !!
if [[ "$(hostname)" == "antipater" ]]
then
  __conda_setup="$('/home/andsild/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/home/andsild/anaconda3/etc/profile.d/conda.sh" ]; then
        true
        # . "/home/andsild/anaconda3/etc/profile.d/conda.sh"  # commented out by conda initialize
      else
          export PATH="/home/andsild/anaconda3/bin:$PATH"
      fi
  fi
fi
unset __conda_setup
# <<< conda initialize <<<

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

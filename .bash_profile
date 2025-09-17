# /etc/skel/.bash_profile
#
if [ -z "$PS1" ]; then
    # Commands here will NOT be executed in non-interactive shells
    return
fi

if [[ -z "${BASH_PROFILE_SOURCED}" ]]
then
  SSH_ENV="$HOME/.ssh/environment"

  function start_agent {
      echo "Initialising new SSH agent..."
      ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
      echo succeeded
      chmod 600 "${SSH_ENV}"
      . "${SSH_ENV}" > /dev/null
      ssh-add;
  } 
  # Source SSH settings, if applicable

  if [ -f "${SSH_ENV}" ]; then
      . "${SSH_ENV}" > /dev/null
      #ps ${SSH_AGENT_PID} doesn't work under cywgin
      ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent > /dev/null || {
      start_agent;
      }
  else
      start_agent;
  fi

  GPG_TTY=$(tty)
  export GPG_TTY
  if [ -e /home/andsild/.nix-profile/etc/profile.d/nix.sh ]; then . /home/andsild/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

  export BASH_PROFILE_SOURCED=1

  # This file is sourced by bash for login shells.  The following line
  # runs your .bashrc and is recommended by the bash info pages.
  [[ -f ~/.bashrc ]] && . ~/.bashrc
fi


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/aza4423/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/aza4423/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/aza4423/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/aza4423/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


[[ -f ~/.bashrc ]] && . ~/.bashrc # ghcup-env

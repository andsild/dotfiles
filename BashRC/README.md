### Example Setup

``ln -s <location of dotfiles directory>/BashRC/bashrc ~/.bashrc``

the bashrc, in turn, will try to source 
* <dotfiles directory>/BashRC/inputrc
* <dotfiles directory>/BashRC/bash_aliases
* <dotfiles directory>/Bash/Sourced/*

and some other files (virtualenv, travis, etc).

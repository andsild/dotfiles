### Example Setup

``ln -s <location of dotfiles directory>/BashRC/bashrc ~/.bashrc``  
Possibly, also  
``ln -s <location of dotfiles directory>/BashRC/bash_profile ~/.bash_profile``
which starts the ssh agent by default and sources bashrc on login.

the bashrc, in turn, will try to source 
* <dotfiles directory>/BashRC/inputrc
* <dotfiles directory>/BashRC/bash_aliases
* <dotfiles directory>/Bash/Sourced/*

and some other files (virtualenv, travis, etc).

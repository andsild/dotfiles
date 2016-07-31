# NVIM
A vimrc that should have acceptable performance for linux and mac.
I use neovim in Windows as well, but with some limitations because of
features that aren't implemented and lacking plugin support.

## Install [_Linux_]
Copy "init.vim" and "plugins.toml" into your `$XDG_CONFIG_HOME/nvim` (default `~/.config/nvim`).  
The rest should install by itself. Note that some plugins fail silently if you
miss dependencies like lua or ruby.
Also, do`pip install --upgrade neovim`.

## Plugins

[dein](https://github.com/Shougo/dein.vim) for plugin management  
[deoplete](https://github.com/Shougo/deoplete.nvim) for omnicompletion  
[neomake](https://github.com/neomake/neomake) for linting and compiler errors  
[fzf](https://github.com/junegunn/fzf.vim) for opening files and doing text-searches  
[suckless.vim](https://github.com/andsild/suckless.vim) for some window management  
[vim-fugitive](https://github.com/tpope/vim-fugitive) for most of my git commands


## Mappings
`<Leader> + <key(s)>`:  toggle a setting.  
`[Space] + <key(s)>`: open a menu  
`; + <key(s)>`: do a window action  
**For example:**  
&nbsp;&nbsp;&nbsp;&nbsp; * `<Leader>sp` enables spellcheck, `<Leader>w` toggles wrap...  
&nbsp;&nbsp;&nbsp;&nbsp; * `[Space]g` opens git menu, `[Space]i` open intellisense menu (python, c#)  
&nbsp;&nbsp;&nbsp;&nbsp; * `;v` open a vsplit, `;t` opens a tab

# Protips
* **Copy command output to register**  
&nbsp;&nbsp;&nbsp;&nbsp;`:redir @a | command | redir end` (for example `verbose map`)  
* **Get output from command**  
&nbsp;&nbsp;&nbsp;&nbsp;`:r !COMMAND` (for example `r !dmesg`)  
* **Preview/test regular expression**  
&nbsp;&nbsp;&nbsp;&nbsp;(from normal mode, type) `?` (for example `?\v<[Ww]ord>`)  
* **Read up on viewports and buffers in vim  
    (https://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/)**


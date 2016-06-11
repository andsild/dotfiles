# VIM
Welcome to my wonderland...

This readme will **not** be updated often.

## Install
[Linux only]  
apt-get install neovim ... (or whichever package manager you have)
`pip install --upgrade neovim`  
The rest should install by itself. Note that some plugins fail silently if you
miss dependencies like lua or ruby.

## Mappings
`<Leader> + <key(s)>`:  toggle a setting.  
`[Space] + <key(s)>`: open a menu  
`; + <key(s)>`: do a window action  
&nbsp;&nbsp;&nbsp;&nbsp; **For example**  
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

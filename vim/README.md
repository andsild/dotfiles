# VIM
Welcome to my wonderland...

This readme will **not** be updated often.

## Install
# Windows
Download and install https://bintray.com/veegee/generic/vim_x64/view  
create the following in your home directory:  
.vimrc:
    `so <path_to_this_repo>/Vim/vimrc`  
    (you only need the vim directory of this repo)
    
launch (g)vim, let it fetch Neobundle...
When finished, hit <Esc>:NeoBundleCheckUpdate  
(this downloads all plugins)

* For plugins:  
Some plugins are written in other languages than vimscript and needs runtime-libraries.

lua 5.2 64-bit dll in PATH: http://sourceforge.net/projects/luabinaries/files/5.2/Windows%20Libraries/Dynamic/lua-5.2_Win64_dll10_lib.zip/download
64-bit python installed (version 2.7) (google it! After install, python2.7.dll should be in ( `%systemroot%\SysWOW64` - which is fine)

Omnisharp-vim requires either xbuild (for linux) or that you have visual studio installed (windows).

After this, you should be able to type:
    `<Esc>:python print("hey")  
    <Esc>:lua dawdaw  
    <Esc>:ruby dawdaw`
without getting missing dll messages. `<Esc>:version` shows what dlls are being looked for and where (with rtp reading from PATH).
    
    


## Roadmap
Starting as of now, I've decided to start migrating FROM vim. This is because
    I miss the concept of "an application should do one thing, and do it well".
* Portage is much better at package management than vim will ever be
* Tiling is much better done in wmii
* vim cannot do asynchronous operations?


The main problem being that many applications provide annoying interfaces, so it's easier using vim-plugins.
One of my future projects may involve finding a nice way to wrap small commands to a menu-based interface like unite, but without vim.

I will keep using vim because it is great for text editing and light (hello emacs). However, I wish to gradually remove some of my 100+ plugins... 

# Workflow
It takes some time to get used to Unite (i.e., the menus that pop up "all the
time"). However, after learning, it can really benefit your workflow.


# Settings
(A mess. I'm occasionally working on cleaning it to ensure a rigid structure)

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
* **Use gvim. It will be easier to migrate to other platforms/environments**  
* **Read up on viewports and buffers in vim  
    (https://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/)**



# (Yet more reasons not to use vim)
#### Compiling
You need to compile vim with a ton of settings to make the setup work.
In your vim --version, make sure you have:  
* +lua (autocompletion and other unite features)  
* +python (...)  
* +ruby (for some git plugins)  

In some systems, this requires downloading the vim source and doing `./configure --with-lua...` etc.  I recommend also appending `--enable-fail-if-missing`. 
I just use gentoo and package.use (https://github.com/andsild/dotfiles/blob/master/portage/package.use) :)  


#### Installing plugins
After adding the repository to neobundle.toml, you need to invoke  
`:NeoBundleClearCache`,  
and then, in a new(fresh) vim-instance (init.rc needs to be re-invoked)    
`:NeoBundleCheck`

Also, be aware that most of the plugins fail silently when there are missing
dependencies. Read their doc (most have a "requirement" section).

#### Other
Note that most of the plugins register with a "filetype" in neobundle.toml. This means that you need to open a buffer before their shortcuts/commands work.

Neovim looks O.K, but I do not understand why they want to continue in C and with old legacy code and vimscript. Furthermore, there's currently not support for lua and python, so I will wait with transitioning. But I like the spirit.

# VIM
Welcome to my wonderland...

# Workflow
It takes some time to get used to Unite (i.e., the menus that pop up "all the
time"). However, once you become a master, it can really benefit your workflow.


# Settings
(A mess. I'm working on cleaning it to ensure a rigid structure)

## Mappings
`<Leader> + <key(s)>`:  toggle a setting.  
`[Space] + <key(s)>`: open a menu  
`; + <key(s)>`: do a window action  
&nbsp;&nbsp;&nbsp;&nbsp; **For example**  
&nbsp;&nbsp;&nbsp;&nbsp; * `<Leader>sp` enables spellcheck, `<Leader>w` toggles wrap...  
&nbsp;&nbsp;&nbsp;&nbsp; * `[Space]g` opens git menu, `[Space]os` open omnisharpmenu  
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



# Watch out
#### Compiling
You need to compile vim with a ton of settings to make the setup work.
In your vim --version, make sure you have:  
* +lua (autocompletion and other unite features)  
* +python (...)  
* +ruby (for some git plugins)  

In some systems, this requires downloading the vim source and doing `./configure --with-lua...` etc.  I recommend also appending `--enable-fail-if-missing`. 
I just use gentoo and package.use (https://github.com/andsild/dotfiles/blob/master/portage/package.use) :)  

To compile a vim-version in windows you need a ton of patience as, even in the "complete pre-built" versions, you need to copy-paste your own DLLs.


#### Installing plugins
After adding the repository to neobundle.toml, you need to invoke  
`:NeoBundleClearCache`,  
and then, in a new(fresh) vim-instance  
`:NeoBundleCheck`

Also, be aware that most of the plugins fail silently when there are missing
dependencies. Read their doc (most have a "requirement" section).

#### Other
Note that most of the plugins register with a "filetype" in neobundle.toml. This means that you need to open a buffer before their shortcuts/commands work.

# Philosophy
Vim sucks. It doesn't come with
* tiling manager (how many times do you have more than one open file when
    coding?)
* asynchronous support (the famous hackernews post: "Can you implement a clock in vim?"
* intuitive setting files (most plugins have both a "plugin" and an "autoload" folder.
    What's the difference? Only plugin developers know).

However, nothing is perfect. Vim has a great community. And because vimscript
is so messy compared to other languages, it means that most vim users tend to use
hacky and IMO, sexy solutions. At least for personal usage :)



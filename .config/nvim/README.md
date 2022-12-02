## Getting neovim
Go to their github page and get their ppa which is usually more up to date than Ubuntu's default

## To install vim-plug:
```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

## Other dependencies (ubuntu)
```bash
sudo apt install -y python3-neovim fd-find
```


## Some of my most used plugins
[plug](https://github.com/junegunn/vim-plug) for plugins
[coc](https://github.com/neoclide/coc.nvim) for autocomplete, etc
[fzf](https://github.com/junegunn/fzf.vim) for opening files and doing text-searches  
[suckless.vim](https://github.com/andsild/suckless.vim) for some window management  
[vim-fugitive](https://github.com/tpope/vim-fugitive) for most of my git commands

# Protips
* **Read up on viewports and buffers in vim  
    (https://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/)**
* **Disable the arrow keys. This will accelerate your vim-foo**

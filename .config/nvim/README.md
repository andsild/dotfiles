# Getting neovim
## Docker
The dockerfile should work if you want that. To make it seamless between the docker environment and the host, run something a la
```bash
docker run --rm --name editor -v ${PWD}:/code -v ${HOME}/dotfiles:/root/dotfiles -v ${HOME}/.gitconfig:/root/.gitconfig -v ${HOME}/miniconda3/envs/conda-env:/opt/conda_env -v ${HOME}/.config/github-copilot:/root/.config/github-copilot --user root -it pesktux/nvim:latest
```

Note that this will also try to mount a conda environment named `conda-env`. This is if you code in python and want autocompletions for that.

## Install manually on Linux:
### Dependencies (ubuntu)
```bash
sudo apt install -y python3-neovim fd-find ripgrep
```
Go to the neovim github page and get their ppa which is usually more up to date than Ubuntu's default.  
Then, install vim-plug:
```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

Now `ln -s dotfiles/.config/nvim ~/.config/`.

Then, when vim opens, ignore the error messages, and call `:PlugInstall` before `:UpdateRemotePlugins`.
Re-open nvim.

Why so many steps to install? Why not automate it?
Because the nvim ecosystem and how I use it keeps changing, so overall I think spending one minute to install it is easier :-)

If you use this repo and have any questions, I'd be happy to answer it.

# Some of my most used plugins
* [plug](https://github.com/junegunn/vim-plug) for plugins
* [coc](https://github.com/neoclide/coc.nvim) for autocomplete, etc
* [fzf](https://github.com/junegunn/fzf.vim) for opening files and doing text-searches  
* [suckless.vim](https://github.com/andsild/suckless.vim) for some window management  
* [vim-fugitive](https://github.com/tpope/vim-fugitive) for most of my git commands

# Protips
* **Read up on viewports and buffers in vim  
    (https://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/)**
* **Disable the arrow keys. This will accelerate your vim-foo**

# My vim philosophy
  * https://qwde.no/blog/my-vim-journey.html
  * https://qwde.no/blog/using-vim-to-review-git-commits.html

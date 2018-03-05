# NVIM
A vimrc for Linux. 

## Install [_Linux_]
nixpkgs might take a few **gigabyte** of storage. Its really cool though! Make sure to run `nix-collect-garbage -d` every now and then to clear disk space.
```bash
# Install nixpkgs (should work on most Linux platforms)
curl https://nixos.org/nix/install | sh
# Add unstable channel, so that you are more up to date for neovim
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update
# Get my vim-config:
git clone https://github.com/andsild/dotfiles ~/andsild-dotfiles
# Setup
mkdir -p ~/.config/nixpkgs/overlays ~/.config/nvim
ln -s ~/andsild-dotfiles/vim/nvim.nix ~/.config/nixpkgs/overlays/nvim.nix
ln -s ~/andsild-dotfiles/vim/init.vim ${XDG_CONFIG_HOME:-~/.config/}/nvim/
ln -s ~/andsild-dotfiles/vim/snippets/ ${XDG_CONFIG_HOME:-~/.config/}/nvim/
# Install
nix-env -i neovim
```
### To update:
```bash
nix-env -u
```
### To remove
```bash
nix-env -e neovim
sed '/nix.sh/d' -i ~/.bash_profile
rm -rfi ~/.nix* ~/.config/nixpkgs # careful with the wildcard!
sudo rm -rfi /nix/
```

## Plugins

[nixpkgs/vam](https://nixos.wiki/wiki/Vim_plugins) for plugin management  
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
&nbsp;&nbsp;&nbsp;&nbsp;  `<Leader>sp` enables spellcheck, `<Leader>w` toggles wrap...  
&nbsp;&nbsp;&nbsp;&nbsp; `[Space]g` opens git menu, `[Space]i` open intellisense menu (python, c#)  
&nbsp;&nbsp;&nbsp;&nbsp; `;v` open a vsplit, `;t` opens a tab

# Protips
* **Read up on viewports and buffers in vim  
    (https://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/)**
* **Disable the arrow keys. This will accelerate your vim-foo**

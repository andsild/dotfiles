{ pkgs }:
# The virtualenv for python3 must have neovim, i.e `pip install neovim`
let 
  customPlugins.vim-choosewin-andsild = pkgs.vimUtils.buildVimPlugin {
    name = "vim-choosewin-andsild";
    src = pkgs.fetchFromGitHub {
      owner = "andsild";
      repo = "vim-choosewin";
      rev = "d75acde46636d6ad641f0898d641a092f1d7f3d0";
      sha256 = "05xrlb27rivc1j2b3ybiyn0ka0yhpyyww8vdchb6gdzx20ir3v3s";
    };
    dependencies = [];

  };
  customPlugins.missing-spellfiles = pkgs.vimUtils.buildVimPlugin {
    name = "missing-spellfiles";
    src = pkgs.fetchFromGitHub {
      owner = "andsild";
      repo = "missing-spellfiles-neovim";
      rev = "8451b4be37d1f81812d4a8dcb94eb29f630846cc";
      sha256 = "0hzghkf2f1gp7x6j96hfqa80738pk0j2wkjjanb37c5fl25mi852";
    };
    dependencies = [];
  };
  customPlugins.wmii-vim = pkgs.vimUtils.buildVimPlugin {
    name = "wmii-vim";
    src = pkgs.fetchFromGitHub {
      owner = "andsild";
      repo = "suckless.vim";
      rev = "010928da00f40392f8ea91b5af7db94b8422427e";
      sha256 = "0hgc1aaa4rp8yqxy473g7a5510b3c82s6ywn0bxjgmdpxax7775z";
    };
    dependencies = [];
  };
  customPlugins.tpopefork = pkgs.vimUtils.buildVimPlugin {
    name = "tpopefork";
    src = pkgs.fetchFromGitHub {
      owner = "andsild";
      repo = "vim-unimpaired";
      rev = "70d9c4c5671abc496a7c649396bac50bfe878da9";
      sha256 = "08bhzpw97dk1klvwrfh1p331w27i10sp9wc3mys1n4byy06gnfn0";
    };
    dependencies = [];
  };
in
{
  customRC = builtins.readFile "/home/andsild/dotfiles/vim/init.vim";  
  vam.knownPlugins = pkgs.vimPlugins // customPlugins;
  vam.pluginDictionaries = [ {
    names = [
    # This plugin parses nix configuration files in vim
    "Cosco"
    "Improved-AnsiEsc"
    "SyntaxRange"
    "WebAPI"
    "caw"
    "clang_complete"
    "committia"
    "concealedyank"
    "context-filetype"
    "csv"
    "cute-python"
    "denite"
    "denite-extra"
    "denite-git"
    "deoplete-go"
    "deoplete-jedi"
    "deoplete-nvim"
    "easygit"
    "echodoc"
    "fugitive"
    "fzfWrapper"
    "fzf-vim"
    "haskell-vim"
    "maktaba"
    "mayansmoke"
    "missing-spellfiles"
    "neco-look"
    "neco-syntax"
    "neco-vim"
    "neoinclude"
    "neomake"
    "neomru"
    "neosnippet"
    "neosnippet-snippets"
    "neoyank"
    "open-browser"
    "peskcolor"
    "prettyprint"
    "riv"
    "sparkup"
    "tabpagebuffer"
    "tabpagecd"
    "tagbar"
    "vim-auto-save"
    "vim-autoformat"
    "vim-bazel"
    "vim-choosewin-andsild"
    "vim-coffee-script"
    "vim-css-color"
    "vim-cursorword"
    "vim-dispatch"
    "vim-easy-align"
    "vim-ft-diff_fold"
    "vim-gitbranch"
    "vim-grepper"
    "vim-haskellConcealPlus"
    "vim-javascript"
    "vim-jsbeautify"
    "vim-json"
    "vim-latex-live-preview"
    "vim-localvimrc"
    "vim-logreview"
    "vim-markdown"
    "vim-niceblock"
    "vim-nix"
    "vim-operator-replace"
    "vim-operator-surround"
    "vim-operator-user"
    "vim-quickrun"
    "vim-repeat"
    "vim-scouter"
    "vim-smalls"
    "vim-test"
    "vim-textobj-multiblock"
    "vim-textobj-user"
    "vim-themis"
    "vim-toml"
    "vim-webdevicons"
    "vim-webdevicons"
    "vim-wordy"
    "xterm-color-table"
    "zeavim"
    "wmii-vim"
    "tpopefork"
    # "ghcmod"
    # "neco-ghc"
    ];
    }
  ];
}

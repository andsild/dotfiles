{ pkgs }:
# The virtualenv for python3 must have neovim, i.e `pip install neovim`
let 
  customPlugins.vim-choosewin = pkgs.vimUtils.buildVimPlugin {
    name = "vim-choosewin";
    src = pkgs.fetchFromGitHub {
      owner = "andsild";
      repo = "vim-choosewin";
      rev = "d75acde46636d6ad641f0898d641a092f1d7f3d0";
      sha256 = "0hzghkf2f1gp7x6j96hfqa80738pk0j2wkjjanb37c5fl25mi852";
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
  customPlugins.fzf = pkgs.vimUtils.buildVimPlugin {
    name = "fzf";
    src = pkgs.fetchFromGitHub {
      owner = "andsild";
      repo = "fzf";
      rev = "cf311dcaaadf4333f7423bdf8cd166acb65bf259";
      sha256 = "161fcl2v3sqiv4d44vnxjx6yp7sfgil87mbg703af643b5shczdk";
    };
    dependencies = [];

  };
in
{
    customRC = ''
        let g:python_host_prog='python2'
        let g:python3_host_prog='python3'
        exe 'source ' . expand('~/dotfiles/vim/init.vim')
        '';
    vam.knownPlugins = pkgs.vimPlugins // customPlugins;
    vam.pluginDictionaries = [
        {
            names = [
            # This plugin parses nix configuration files in vim
            "auto-pairs"
            "Cosco"
            "SyntaxRange"
            "WebAPI"
            "caw"
            "csv"
            "deoplete-go"
            "deoplete-jedi"
            "deoplete-nvim"
            "easygit"
            "editorconfig-vim"
            "fugitive"
            "fzf-vim"
            # "ghcmod"
            "haskell-vim"
            "maktaba"
            # "neco-ghc"
            "neco-look"
            "neco-vim"
            "neomake"
            "neosnippet"
            "neosnippet-snippets"
            "prettyprint"
            "riv"
            "sparkup"
            "tabpagecd"
            "tagbar"
            "vim-auto-save"
            "vim-autoformat"
            "vim-coffee-script"
            "vim-css-color"
            "vim-cursorword"
            "vim-dispatch"
            "vim-easy-align"
            "vim-ft-diff_fold"
            "vim-dashboard"
            "vim-haskellConcealPlus"
            "vim-javascript"
            "vim-jsbeautify"
            "vim-latex-live-preview"
            "vim-localvimrc"
            "vim-logreview"
            "vim-markdown"
            "vim-nix"
            "vim-quickrun"
            "vim-repeat"
            "vim-scouter"
            "vim-webdevicons"
            "vim-webdevicons"
            "xterm-color-table"
            "zeavim"
            "denite"
            "tabpagebuffer"
            "neomru"
            "echodoc"
            "context-filetype"
            "vim-niceblock"
            "vim-json"
            "open-browser"
            "vim-operator-user"
            "vim-operator-replace"
            "vim-operator-surround"
            "concealedyank"
            "vim-textobj-user"
            "vim-textobj-multiblock"
            "previm"
            "vim-themis"
            "vim-toml"
            "vim-smalls"
            "suckless-vim"
            "cute-python"
            "neoinclude"
            "committia"
            "neco-syntax"
            "vim-grepper"
            "vim-test"
            "peskcolor"
            "mayansmoke"
            "neoyank"
            "intero-neovim"
            "denite-git"
            "denite-extra"
            "vim-bazel"
            "vim-wordy"
            "Improved-AnsiEsc"
            "vim-gitbranch"
            "missing-spellfiles"
            "fzf"
            "vim-choosewin"
            "clang_complete"
            ];
        }
    ];
}

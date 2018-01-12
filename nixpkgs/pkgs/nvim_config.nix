{ pkgs }:
# The virtualenv for python3 must have neovim, i.e `pip install neovim`
{
    customRC = ''
        let g:python_host_prog=expand('~/python2env/bin/python')
        let g:python3_host_prog=expand('~/python3env/bin/python')
        exe 'source ' . expand('~/dotfiles/vim/init.vim')
        '';
    vam.knownPlugins = pkgs.vimPlugins;
    vam.pluginDictionaries = [
        {
            names = [
            # This plugin parses nix configuration files in vim
            "AnsiEsc"
            "Auto_Pairs"
            "BufOnly"
            "Cosco"
            "SyntaxRange"
            "WebAPI"
            "autofmt"
            "camelcasemotion"
            "caw"
            "csv"
            "deoplete-go"
            "deoplete-jedi"
            "deoplete-nvim"
            "easygit"
            "editorconfig-vim"
            "fugitive"
            "fzf-vim"
            "ghcmod"
            "haskell-vim"
            "maktaba"
            "mayansmoke"
            "neco-ghc"
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
            "vim-github-dashboard"
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
            ];
        }
    ];
}

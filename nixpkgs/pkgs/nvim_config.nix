{ pkgs }:
# The virtualenv for python3 must have neovim, i.e `pip install neovim`
{
    customRC = ''
        let g:python_host_prog=expand('~/python2env/bin/python')
        let g:python3_host_prog=expand('~/python3env/bin/python')
        exe 'source ' . expand('~/dotfiles/vim/init.vim')
        '';
    vam.pluginDictionaries = [
        {
            names = [
            # This plugin parses nix configuration files in vim
                "vim-nix"
            ];
        }
    ];
}

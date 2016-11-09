{ pkgs }:
{
    customRC = ''
        let g:python_host_prog=expand('~/python2env/bin/python')
        let g:python3_host_prog=expand('~/defaultenv3/bin/python')
        exe 'source ' . expand('~/dotfiles/vim/init.vim')
        '';
    vam.pluginDictionaries = [
        {
            names = [
                "vim-nix"
            ];
        }
    ];
}

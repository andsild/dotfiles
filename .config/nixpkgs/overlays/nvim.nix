self: super:

let 
  customPlugins.vim-choosewin-andsild = super.vimUtils.buildVimPlugin {
    name = "vim-choosewin-andsild";
    src = super.fetchFromGitHub {
      owner = "andsild";
      repo = "vim-choosewin";
      rev = "d75acde46636d6ad641f0898d641a092f1d7f3d0";
      sha256 = "05xrlb27rivc1j2b3ybiyn0ka0yhpyyww8vdchb6gdzx20ir3v3s";
    };
    dependencies = [];

  };
  customPlugins.missing-spellfiles = super.vimUtils.buildVimPlugin {
    name = "missing-spellfiles";
    src = super.fetchFromGitHub {
      owner = "andsild";
      repo = "missing-spellfiles-neovim";
      rev = "8451b4be37d1f81812d4a8dcb94eb29f630846cc";
      sha256 = "0hzghkf2f1gp7x6j96hfqa80738pk0j2wkjjanb37c5fl25mi852";
    };
    dependencies = [];
  };
  customPlugins.wmii-vim = super.vimUtils.buildVimPlugin {
    name = "wmii-vim";
    src = super.fetchFromGitHub {
      owner = "andsild";
      repo = "suckless.vim";
      rev = "010928da00f40392f8ea91b5af7db94b8422427e";
      sha256 = "0hgc1aaa4rp8yqxy473g7a5510b3c82s6ywn0bxjgmdpxax7775z";
    };
    dependencies = [];
  };
  customPlugins.tpopefork = super.vimUtils.buildVimPlugin {
    name = "tpopefork";
    src = super.fetchFromGitHub {
      owner = "andsild";
      repo = "vim-unimpaired";
      rev = "70d9c4c5671abc496a7c649396bac50bfe878da9";
      sha256 = "08bhzpw97dk1klvwrfh1p331w27i10sp9wc3mys1n4byy06gnfn0";
    };
    dependencies = [];
  };
  customPlugins.vim-textobj-user = super.vimUtils.buildVimPlugin {
    name = "vim-textobj-user";
    src = super.fetchFromGitHub {
      owner = "kana";
      repo = "vim-textobj-user";
      rev = "e231b65797b5765b3ee862d71077e9bd56f3ca3e";
      sha256 = "0zsgr2cn8s42d7jllnxw2cvqkl27lc921d1mkph7ny7jgnghaay9";
    };
    dependencies = [];
  };
  customPlugins.plantuml-syntax = super.vimUtils.buildVimPlugin {
    name = "plantuml-syntax";
    src = super.fetchFromGitHub {
      owner = "aklt";
      repo = "plantuml-syntax";
      rev = "41eeca5a548c7d3bcc7b86758a1f10b7d96aa0b9";
      sha256 = "1v11dj4vwk5hyx0zc8qkl0a5wh91zfmwhcq2ndl8zwp78h9yf5wr";
    };
    dependencies = [];
  };
  customPlugins.plantuml-previewer-vim = super.vimUtils.buildVimPlugin {
    name = "plantuml-previewer.vim";
    src = super.fetchFromGitHub {
      owner = "weirongxu";
      repo = "plantuml-previewer.vim";
      rev = "5dac592bf04a13ebf02942a242ba18ac6c429c63";
      sha256 = "1jcbfk6k6jwgzf5zdqzlv94k0l5qdx8gs16ach4i7xgsb9pj4125";
    };
    dependencies = ["plantuml-syntax"];
  };
  customPlugins.previm = super.vimUtils.buildVimPlugin {
    name = "previm";
    src = super.fetchFromGitHub {
      owner = "andsild";
      repo = "previm";
      rev = "9bbb7fb83edd4ade8fa6dc719ba1127da70e16f7";
      sha256 = "0mwiaq8xrnnz5j3pihj5iafbv8j5w9zl93cnh4p1zdimg9v74v4m";
    };
    dependencies = [];
  };

  customPlugins.vim-godot = super.vimUtils.buildVimPlugin {
    name = "previm";
    src = super.fetchFromGitHub {
      owner = "habamax";
      repo = "vim-godot";
      rev = "e38845b4042d2351c47cd63f8705fd51c97acb4f";
      sha256 = "1k3val0ibriwcv5jdyq95sgxgkz54r15gpylbhns5934zvaakpj1";
    };
    dependencies = [];
  };

  vimconfig = {
    # customRC = builtins.readFile "/home/andsild/dotfiles/vim/init.vim";  
    customRC = ''source $XDG_CONFIG_HOME/nvim/init.vim '';
    vam.knownPlugins = super.vimPlugins // customPlugins;
    vam.pluginDictionaries = [ {
      names = [
      # This plugin parses nix configuration files in vim
      "Cosco"
      "Improved-AnsiEsc"
      "SyntaxRange"
      "WebAPI"
      "caw"
      "vim-godot"
      "clang_complete"
      "committia"
      #"context-filetype"
      "cute-python"
      "easygit"
      "echodoc"
      "fugitive"
      "fzfWrapper"
      "fzf-vim"
      "haskell-vim"
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
      "neoyank-vim"
      "peskcolor-vim"
      "prettyprint"
      "riv"
      "wmii-vim"
      "tabpagebuffer"
      "tabpagecd"
      "tagbar"
      "vim-auto-save"
      "vim-autoformat"
      "vim-choosewin-andsild"
      "vim-coffee-script"
      "vim-css-color"
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
      "vim-repeat"
      "vim-smalls"
      "denite"
      "denite-extra"
      "denite-git"
      "vim-test"
      "vim-themis"
      "vim-toml"
      "vim-wordy"
      "zeavim"
      "wmii-vim"
      "tpopefork"
      "plantuml-syntax"
      "plantuml-previewer-vim"
      "previm"
      ];
      }
    ];
  };
in
{
  neovim = super.neovim.override {
    vimAlias = true;
    withPython = true;
    withPython3 = true;
    withRuby = true;
    extraPython3Packages = ps: with ps; [ pylint numpy scipy jedi ipdb unittest2 pytest ];
    configure = vimconfig;
  };
}

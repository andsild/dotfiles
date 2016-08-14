{ pkgs
}:

rec { 
  st = pkgs.st.override {
    conf = import ./st_config.nix {} ;
  };

  environment.variables = rec {
      VISUAL  = "nvim";
      EDITOR  = VISUAL;
      BROWSER = "chromium-browser";
    };

  neovim = pkgs.neovim.override {
    vimAlias = true;
    withPython = true;
    withPython3 = true;
    configure = import ./nvim_config.nix { inherit pkgs; };
  };

}

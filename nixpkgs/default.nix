{ system ? builtins.currentSystem }:

let 
	pkgs = import <nixpkgs> { inherit system; };

	callPackage = pkgs.lib.callPackageWith (pkgs // self);

	self = {
    bazel = pkgs.callPackage ./pkgs/bazel {
    };

	  st = pkgs.callPackage ./pkgs/st {
	    conf = import ./pkgs/st_config.nix {} ;
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
        withRuby = true;

        withPyGUI = true;
	    configure = import ./pkgs/nvim_config.nix { inherit pkgs; };
	  };
	};
	in self

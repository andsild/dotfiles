{ system ? builtins.currentSystem }:

let 
	pkgs = import <nixpkgs> { inherit system; };

	callPackage = pkgs.lib.callPackageWith (pkgs // self);

	self = {

	  st = pkgs.callPackage ./pkgs/st {
	    conf = import ./pkgs/st_config.nix {} ;
	  };

	  environment.variables = rec {
	      VISUAL  = "nvim";
	      EDITOR  = VISUAL;
	      BROWSER = "chromium-browser";
	    };

    checkstyle = pkgs.callPackage ./pkgs/checkstyle {
    };

    bazel = pkgs.callPackage ./pkgs/bazel {
      jdk = pkgs.oraclejdk;
    };

	  workrave = pkgs.callPackage ./pkgs/workrave {
      inherit (pkgs.gnome2) GConf gconfmm;
      inherit (pkgs.python27Packages) cheetah;
      gtk = pkgs.gtk2;
      gtkmm = pkgs.gtkmm2;
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

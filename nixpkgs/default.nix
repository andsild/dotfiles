{ system ? builtins.currentSystem }:

let 
	pkgs = import <myFork> { inherit system; };

	callPackage = pkgs.lib.callPackageWith (pkgs // self);

	self = {

    bazel = pkgs.callPackage ./pkgs/bazel {
      # jdk = pkgs.oraclejdk;
      # enableNixHacks = false;
    };

    checkstyle = pkgs.callPackage ./pkgs/checkstyle {
    };

	  neovim = pkgs.neovim.override {
	    vimAlias = true;
	    withPython = true;
	    withPython3 = true;
      withRuby = true;
      extraPython3Packages = with pkgs.python3Packages;  [ pylint neovim numpy scipy jedi ipdb unittest2 pytest ];
      withPyGUI = true;
	    configure = import ./pkgs/nvim_config.nix { inherit pkgs; };
	  };

    neovim-qt = pkgs.neovim-qt;

	  st = pkgs.callPackage ./pkgs/st {
	    conf = import ./pkgs/st_config.nix {} ;
	  };

	  workrave = pkgs.callPackage ./pkgs/workrave {
      inherit (pkgs.gnome2) GConf gconfmm;
      inherit (pkgs.python27Packages) cheetah;
      gtk = pkgs.gtk2;
      gtkmm = pkgs.gtkmm2;
	  };

	};
	in self

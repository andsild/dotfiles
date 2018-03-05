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
	};
	in self

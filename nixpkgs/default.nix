{ system ? builtins.currentSystem }:

let 
	pkgs = import <myFork> { inherit system; };

	callPackage = pkgs.lib.callPackageWith (pkgs // self);

	self = {

    checkstyle = pkgs.callPackage ./pkgs/checkstyle {
    };
    
    myEclipse = with pkgs.eclipses; eclipseWithPlugins {
      eclipse = eclipse-platform-47;
      jvmArgs = [ "-Xmx2048m" "-Xms2048m" ];
      plugins = with plugins; [ checkstyle color-theme findbugs jdt vrapper testng ];
    };
	};
	in self

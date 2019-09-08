{ system ? builtins.currentSystem }:

let
  pkgs = import <myFork> { inherit system; };
  cctools = pkgs.cctools;
  CoreFoundation = pkgs.CoreFoundation;
  CoreServices = pkgs.CoreServices;
  Foundation = pkgs.Foundation;

  callPackage = pkgs.lib.callPackageWith (pkgs // self);

  self = {
    checkstyle = pkgs.callPackage ./pkgs/checkstyle {
    };


    bazel = pkgs.callPackage ./pkgs/bazel {
        inherit cctools;
        inherit CoreFoundation CoreServices Foundation;
    };

    myEclipse = with pkgs.eclipses; eclipseWithPlugins {
      eclipse = eclipse-platform;
      jvmArgs = [ "-Xmx2048m" "-Xms2048m" ];
      plugins = with plugins; [ checkstyle color-theme findbugs jdt vrapper testng ];
    };
  };

  in self

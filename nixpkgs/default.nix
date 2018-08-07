{ system ? builtins.currentSystem }:

let 
  pkgs = import <myFork> { inherit system; };

  callPackage = pkgs.lib.callPackageWith (pkgs // self);

  self = {
    checkstyle = pkgs.callPackage ./pkgs/checkstyle {
    };
  };
  
  in self

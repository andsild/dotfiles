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
  };

  in self

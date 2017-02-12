{nixpkgs ? import <nixpkgs> { }, compiler ? "ghc801"}:

let
  inherit (nixpkgs) pkgs;
  ghc = pkgs.haskell.packages.${compiler}.ghcWithHoogle (ps: with ps; [
        ]);
in
nixpkgs.haskell.lib.buildStackProject {
  name = "default-stack-shell";
  buildInputs = with pkgs; [
    git links2 xdg_utils zlib
  ];
  LANG = "en_US.UTF-8";
  inherit ghc;
  shellHook = "eval $(egrep ^export ${ghc}/bin/ghc)";
}

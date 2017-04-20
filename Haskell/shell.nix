{nixpkgs ? import <nixpkgs> { }, compiler ? "ghc802"}:

let
  inherit (nixpkgs) pkgs;
  ghc = pkgs.haskell.packages.${compiler}.ghcWithHoogle (ps: with ps; [
    repa
        ]);
in
nixpkgs.haskell.lib.buildStackProject {
  name = "default-stack-shell";
  buildInputs = with pkgs; [
    git links2 xdg_utils zlib haskellPackages.intero haskellPackages.hlint llvm_37 less gmp
    # this is silly, but I want setsid (libuuid) and mplayer to play vids after test runs
    libuuid mplayer
  ];
  LANG = "en_US.UTF-8";
  inherit ghc;
}


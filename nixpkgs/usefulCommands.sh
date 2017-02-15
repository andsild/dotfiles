#!/usr/bin/env bash

# point to your fork
export NIXPKGS=/home/andesil/nixpkgs/

# From inside your fork's directory, you can build stuff
# This is the command to use for the most part when working nixpkgs
nix-build -A yourpackage
# And test output binary
./result/bin/resulting_binary

# This might not do what it intends (if you have a nix-daemon in background) but it does *something*
nix-env -f $NIXPKGS --option build-use-chroot true --option use-binary-caches false -i yourpackage

# Interactive shell, bruh
nix-shell -I nixpkgs=. --pure -p yourpackage --command "something"


# Test other dependencies 
nix-shell -p nox --run "nox-review wip --against upstream/master"

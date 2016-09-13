{ config, pkgs, ... }:

{
  imports = [ 
    ./core.nix ./hardware-setup-bigmomma.nix ];

 networking.hostName = "peskNix";
}


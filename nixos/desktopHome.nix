{ config, pkgs, ... }:

{
  imports = [ 
    ./core.nix ./hardware-setup-bigmomma.nix ];

 networking.hostName = "peskNix";
 services.xserver.xrandrHeads = [ "DVI-0" "DisplayPort-1"];
}


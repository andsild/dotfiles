{ config, pkgs, ... }:

{
  imports = [ 
    ./core.nix ];

 networking.hostName = "miniPeskNix";
 networking.wireless.interfaces = [ "wlp3s0" ];
}

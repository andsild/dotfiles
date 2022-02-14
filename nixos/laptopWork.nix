{ config, pkgs, ... }:

{
  imports = [ 
    ./newCore.nix ];

 networking.hostName = "miniPeskNix";
 # networking.wireless.userControlled.enable = true;
 # networking.wireless.userControlled.group = "wheel";

  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Name="%h-nix";
      AutoConnectTimeout = "30";
      FastConnectable = "true";
      NameResolving = "false";
    };
  };
}

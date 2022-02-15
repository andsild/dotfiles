{ config, pkgs, ... }:

{
  imports = [ 
    ./core.nix ];

    boot.extraModulePackages = [ config.boot.kernelPackages.rtw89 ];

    networking.hostName = "miniPeskNix";

    hardware = {
      bluetooth = {
        enable = true; 
        disabledPlugins = [ "sap" ];
        settings = {
          General = {
            Name="%h-nix";
            # AutoConnectTimeout = "30";
            # FastConnectable = "true";
            # NameResolving = "false";
        };
      };
    };
  };
}

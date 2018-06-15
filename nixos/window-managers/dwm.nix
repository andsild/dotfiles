{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.services.customXServer.windowManager.dwm;

in

{

  ###### interface

  options = {
    services.customXServer.windowManager.dwm.enable = mkEnableOption "dwm";
  };


  ###### implementation

  config = mkIf cfg.enable {

    services.customXServer.windowManager.session = singleton
      { name = "dwm";
        start =
          ''
            ${pkgs.dwm}/bin/dwm &
            waitPID=$!
          '';
      };

    environment.systemPackages = [ pkgs.dwm ];

  };

}

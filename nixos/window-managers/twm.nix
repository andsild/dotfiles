{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.services.customXServer.windowManager.twm;

in

{

  ###### interface

  options = {
    services.customXServer.windowManager.twm.enable = mkEnableOption "twm";
  };


  ###### implementation

  config = mkIf cfg.enable {

    services.customXServer.windowManager.session = singleton
      { name = "twm";
        start =
          ''
            ${pkgs.xorg.twm}/bin/twm &
            waitPID=$!
          '';
      };

    environment.systemPackages = [ pkgs.xorg.twm ];

  };

}

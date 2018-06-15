{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.customXServer.windowManager.icewm;
in
{
  ###### interface
  options = {
    services.customXServer.windowManager.icewm.enable = mkEnableOption "icewm";
  };

  ###### implementation
  config = mkIf cfg.enable {
    services.customXServer.windowManager.session = singleton
      { name = "icewm";
        start =
          ''
            ${pkgs.icewm}/bin/icewm &
            waitPID=$!
          '';
      };

    environment.systemPackages = [ pkgs.icewm ];
  };
}

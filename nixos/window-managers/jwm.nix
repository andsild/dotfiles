{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.customXServer.windowManager.jwm;
in
{
  ###### interface
  options = {
    services.customXServer.windowManager.jwm.enable = mkEnableOption "jwm";
  };

  ###### implementation
  config = mkIf cfg.enable {
    services.customXServer.windowManager.session = singleton {
      name = "jwm";
      start = ''
        ${pkgs.jwm}/bin/jwm &
        waitPID=$!
      '';
    };
    environment.systemPackages = [ pkgs.jwm ];
  };
}

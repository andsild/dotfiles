{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.customXServer.windowManager.stumpwm;
in

{
  options = {
    services.customXServer.windowManager.stumpwm.enable = mkEnableOption "stumpwm";
  };

  config = mkIf cfg.enable {
    services.customXServer.windowManager.session = singleton {
      name = "stumpwm";
      start = ''
        ${pkgs.stumpwm}/bin/stumpwm &
        waitPID=$!
      '';
    };
    environment.systemPackages = [ pkgs.stumpwm ];
  };
}

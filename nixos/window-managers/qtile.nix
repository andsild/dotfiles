{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.customXServer.windowManager.qtile;
in

{
  options = {
    services.customXServer.windowManager.qtile.enable = mkEnableOption "qtile";
  };

  config = mkIf cfg.enable {
    services.customXServer.windowManager.session = [{
      name = "qtile";
      start = ''
        ${pkgs.qtile}/bin/qtile
        waitPID=$!
      '';
    }];
    
    environment.systemPackages = [ pkgs.qtile ];
  };
}

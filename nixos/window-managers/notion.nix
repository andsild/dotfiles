{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.customXServer.windowManager.notion;
in

{
  options = {
    services.customXServer.windowManager.notion.enable = mkEnableOption "notion";
  };

  config = mkIf cfg.enable {
    services.customXServer.windowManager = {
      session = [{
        name = "notion";
        start = ''
          ${pkgs.notion}/bin/notion &
          waitPID=$!
        '';
      }];
    };
    environment.systemPackages = [ pkgs.notion ];
  };
}

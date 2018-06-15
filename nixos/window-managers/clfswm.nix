{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.customXServer.windowManager.clfswm;
in

{
  options = {
    services.customXServer.windowManager.clfswm.enable = mkEnableOption "clfswm";
  };

  config = mkIf cfg.enable {
    services.customXServer.windowManager.session = singleton {
      name = "clfswm";
      start = ''
        ${pkgs.clfswm}/bin/clfswm &
        waitPID=$!
      '';
    };
    environment.systemPackages = [ pkgs.clfswm ];
  };
}

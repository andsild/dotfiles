{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.customXServer.windowManager.windowmaker;
in
{
  ###### interface
  options = {
    services.customXServer.windowManager.windowmaker.enable = mkEnableOption "windowmaker";
  };

  ###### implementation
  config = mkIf cfg.enable {
    services.customXServer.windowManager.session = singleton {
      name = "windowmaker";
      start = ''
        ${pkgs.windowmaker}/bin/wmaker &
        waitPID=$!
      '';
    };
    environment.systemPackages = [ pkgs.windowmaker ];
  };
}

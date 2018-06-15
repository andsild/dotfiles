{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.customXServer.windowManager.fluxbox;
in
{
  ###### interface
  options = {
    services.customXServer.windowManager.fluxbox.enable = mkEnableOption "fluxbox";
  };

  ###### implementation
  config = mkIf cfg.enable {
    services.customXServer.windowManager.session = singleton {
      name = "fluxbox";
      start = ''
        ${pkgs.fluxbox}/bin/startfluxbox &
        waitPID=$!
      '';
    };
    environment.systemPackages = [ pkgs.fluxbox ];
  };
}

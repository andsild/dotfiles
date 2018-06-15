{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.customXServer.windowManager.mwm;
in
{
  ###### interface
  options = {
    services.customXServer.windowManager.mwm.enable = mkEnableOption "mwm";
  };

  ###### implementation
  config = mkIf cfg.enable {
    services.customXServer.windowManager.session = singleton {
      name = "mwm";
      start = ''
        ${pkgs.motif}/bin/mwm &
        waitPID=$!
      '';
    };
    environment.systemPackages = [ pkgs.motif ];
  };
}

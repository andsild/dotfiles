{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.customXServer.windowManager.pekwm;
in
{
  ###### interface
  options = {
    services.customXServer.windowManager.pekwm.enable = mkEnableOption "pekwm";
  };

  ###### implementation
  config = mkIf cfg.enable {
    services.customXServer.windowManager.session = singleton {
      name = "pekwm";
      start = ''
        ${pkgs.pekwm}/bin/pekwm &
        waitPID=$!
      '';
    };
    environment.systemPackages = [ pkgs.pekwm ];
  };
}

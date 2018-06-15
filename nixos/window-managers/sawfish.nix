{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.customXServer.windowManager.sawfish;
in
{
  ###### interface
  options = {
    services.customXServer.windowManager.sawfish.enable = mkEnableOption "sawfish";
  };

  ###### implementation
  config = mkIf cfg.enable {
    services.customXServer.windowManager.session = singleton {
      name = "sawfish";
      start = ''
        ${pkgs.sawfish}/bin/sawfish &
        waitPID=$!
      '';
    };
    environment.systemPackages = [ pkgs.sawfish ];
  };
}

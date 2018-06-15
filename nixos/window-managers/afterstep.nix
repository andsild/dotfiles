{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.customXServer.windowManager.afterstep;
in
{
  ###### interface
  options = {
    services.customXServer.windowManager.afterstep.enable = mkEnableOption "afterstep";
  };

  ###### implementation
  config = mkIf cfg.enable {
    services.customXServer.windowManager.session = singleton {
      name = "afterstep";
      start = ''
        ${pkgs.afterstep}/bin/afterstep &
        waitPID=$!
      '';
    };
    environment.systemPackages = [ pkgs.afterstep ];
  };
}

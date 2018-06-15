{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.customXServer.windowManager.oroborus;
in
{
  ###### interface
  options = {
    services.customXServer.windowManager.oroborus.enable = mkEnableOption "oroborus";
  };

  ###### implementation
  config = mkIf cfg.enable {
    services.customXServer.windowManager.session = singleton {
      name = "oroborus";
      start = ''
        ${pkgs.oroborus}/bin/oroborus &
        waitPID=$!
      '';
    };
    environment.systemPackages = [ pkgs.oroborus ];
  };
}

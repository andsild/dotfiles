
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.customXServer.windowManager.spectrwm;
in

{
  options = {
    services.customXServer.windowManager.spectrwm.enable = mkEnableOption "spectrwm";
  };

  config = mkIf cfg.enable {
    services.customXServer.windowManager = {
      session = [{
        name = "spectrwm";
        start = ''
          ${pkgs.spectrwm}/bin/spectrwm &
          waitPID=$!
        '';
      }];
    };
    environment.systemPackages = [ pkgs.spectrwm ];
  };
}

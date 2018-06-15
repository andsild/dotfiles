{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.customXServer.windowManager.ratpoison;
in
{
  ###### interface
  options = {
    services.customXServer.windowManager.ratpoison.enable = mkEnableOption "ratpoison";
  };

  ###### implementation
  config = mkIf cfg.enable {
    services.customXServer.windowManager.session = singleton {
      name = "ratpoison";
      start = ''
        ${pkgs.ratpoison}/bin/ratpoison &
        waitPID=$!
      '';
    };
    environment.systemPackages = [ pkgs.ratpoison ];
  };
}

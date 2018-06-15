{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.services.customXServer.desktopManager.xterm;

in

{
  options = {

    services.customXServer.desktopManager.xterm.enable = mkOption {
      default = true;
      example = false;
      description = "Enable a xterm terminal as a desktop manager.";
    };

  };

  config = mkIf (config.services.customXServer.enable && cfg.enable) {

    services.customXServer.desktopManager.session = singleton
      { name = "xterm";
        start = ''
          ${pkgs.xterm}/bin/xterm -ls &
          waitPID=$!
        '';
      };

    environment.systemPackages = [ pkgs.xterm ];

  };

}

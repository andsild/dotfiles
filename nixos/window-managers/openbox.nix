{lib, pkgs, config, ...}:

with lib;
let
  inherit (lib) mkOption mkIf;
  cfg = config.services.customXServer.windowManager.openbox;
in

{
  options = {
    services.customXServer.windowManager.openbox.enable = mkEnableOption "openbox";
  };

  config = mkIf cfg.enable {
    services.customXServer.windowManager = {
      session = [{
        name = "openbox";
        start = "
          ${pkgs.openbox}/bin/openbox-session
        ";
      }];
    };
    environment.systemPackages = [ pkgs.openbox ];
  };
}

{lib, pkgs, config, ...}:

let
  cfg = config.services.customXServer.windowManager.windowlab;
in

{
  options = {
    services.customXServer.windowManager.windowlab.enable =
      lib.mkEnableOption "windowlab";
  };

  config = lib.mkIf cfg.enable {
    services.customXServer.windowManager = {
      session =
        [{ name  = "windowlab";
           start = "${pkgs.windowlab}/bin/windowlab";
        }];
    };
    environment.systemPackages = [ pkgs.windowlab ];
  };
}

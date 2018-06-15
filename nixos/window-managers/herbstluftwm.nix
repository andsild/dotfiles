{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.customXServer.windowManager.herbstluftwm;
in

{
  options = {
    services.customXServer.windowManager.herbstluftwm.enable = mkEnableOption "herbstluftwm";
  };

  config = mkIf cfg.enable {
    services.customXServer.windowManager.session = singleton {
      name = "herbstluftwm";
      start = "
        ${pkgs.herbstluftwm}/bin/herbstluftwm
      ";
    };
    environment.systemPackages = [ pkgs.herbstluftwm ];
  };
}

{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.customXServer.windowManager;
in

{
  imports = [
    ./wmii.nix
    ./xmonad.nix
    ./none.nix ];

  options = {

    services.customXServer.windowManager = {

      session = mkOption {
        internal = true;
        default = [];
        example = [{
          name = "wmii";
          start = "...";
        }];
        description = ''
          Internal option used to add some common line to window manager
          scripts before forwarding the value to the
          <varname>displayManager</varname>.
        '';
        apply = map (d: d // {
          manage = "window";
        });
      };

      default = mkOption {
        type = types.str;
        default = "none";
        example = "wmii";
        description = "Default window manager loaded if none have been chosen.";
        apply = defaultWM:
          if any (w: w.name == defaultWM) cfg.session then
            defaultWM
          else
            throw "Default window manager (${defaultWM}) not found.";
      };

    };

  };

  config = {
    services.customXServer.displayManager.session = cfg.session;
  };
}

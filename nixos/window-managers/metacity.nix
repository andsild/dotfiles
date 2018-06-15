{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.services.customXServer.windowManager.metacity;
  xorg = config.services.customXServer.package;
  gnome = pkgs.gnome;

in

{
  options = {
    services.customXServer.windowManager.metacity.enable = mkEnableOption "metacity";
  };

  config = mkIf cfg.enable {

    services.customXServer.windowManager.session = singleton
      { name = "metacity";
        start = ''
          env LD_LIBRARY_PATH=${lib.makeLibraryPath [ xorg.libX11 xorg.libXext ]}:/usr/lib/
          # !!! Hack: load the schemas for Metacity.
          GCONF_CONFIG_SOURCE=xml::~/.gconf ${gnome.GConf.out}/bin/gconftool-2 \
            --makefile-install-rule ${gnome.metacity}/etc/gconf/schemas/*.schemas # */
          ${gnome.metacity}/bin/metacity &
          waitPID=$!
        '';
      };

    environment.systemPackages = [ gnome.metacity ];

  };

}

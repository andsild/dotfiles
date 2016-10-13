{ config, pkgs, ... }:

{
  imports = [ 
    ./core.nix ./hardware-setup-bigmomma.nix ];

 networking.hostName = "peskNix";
 services.xserver.xrandrHeads = [ "HDMI-0" "DisplayPort-1"  ];
 services.xserver.deviceSection = ''
 Option "RandRRotation" "on"
 '';
 services.xserver.monitorSection = ''
 Option "Rotate" "left"
 '';
  
 #services.xserver.xrandrHeads = [ "HDMI-0" { output = "DisplayPort-1"; primary = true; monitorConfig = "Option \"Rotate\" \"Left\""; } ];

 services.wakeonlan.interfaces = [{ interface = "enp2s0"; }];
}


{ config, pkgs, ... }:

{

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/lvmroot";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "ext4";
    };
  };

  imports = [ ./core.nix ];



 networking.hostName = "peskNix";
 networking.extraHosts = ''
 192.168.1.207 laptop
 192.168.1.168 phone
 '';
 # services.xserver.xrandrHeads = [ "HDMI-0" "DisplayPort-1" ];
 #services.xserver.deviceSection = ''
 #Option "RandRRotation" "on"
 #'';
 #services.xserver.monitorSection = ''
 #Option "Rotate" "normal"
 #'';
  
 services.xserver.xrandrHeads = [ "HDMI-1" { output = "DisplayPort-1"; primary = true; monitorConfig = "Option \"Rotate\" \"Left\""; } ];

 services.wakeonlan.interfaces = [{ interface = "enp2s0"; }];

}


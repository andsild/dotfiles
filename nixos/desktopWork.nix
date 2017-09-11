{ config, ... }:

{
  imports = [ 
    ./core.nix ];

 networking.hostName = "Caligula";

 services.xserver.videoDrivers = [ "nvidia" ];

 services.xserver.xrandrHeads = [ 
   "HDMI-1" 
   { output = "DisplayPort-1"; 
     primary = true;
     monitorConfig = "Option \"Rotate\" \"Left\"";
   }
 ];
}

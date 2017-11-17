{ config, ... }:

{
  imports = [ 
    ./core.nix ];

 networking.hostName = "Caligula";

 services.xserver.videoDrivers = [ "nvidia" ];
 # services.customXServer.videoDrivers = [ "nvidia" ];
 #services.xserver.xrandrHeads = [ 
 # services.customXServer.xrandrHeads = [ 
   #{ output = "DP-1"; 
   #  primary = true;
   #  monitorConfig = ''
   #  Option "Rotate" "Right"
   #  Option "Position" "0 0"
   #  Option "LeftOf" "HDMI-0"
   #  '';
   #}
   #{ output = "HDMI-0" ;
   #  monitorConfig = ''
   #  Option "Position" "1440 0"
   #  Option "LeftOf" "DP-1"
   #  Option "RightOf" "DVI-D-0"
   #   '';
   #}
   #{ output = "DVI-D-0"; 
   #  monitorConfig = ''
   #  Option "Position" "4000 0"
   #  Option "RightOf" "HDMI-0"
   #  '';
   # }
 # ];
}

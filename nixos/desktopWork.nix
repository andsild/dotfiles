{ config, ... }:

{
  imports = [ 
    ./core.nix ];

 networking.hostName = "Caligula";
}

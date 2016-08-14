{ config, ... }:
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

}

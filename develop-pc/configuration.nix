{ pkgs, lib, ... }:
{
  imports =
    [
      ../modules/common
      ../modules/hardware/asus.nix
      ../modules/hardware/displaylink.nix
      ../modules/hardware/nvidia-prime.nix
      ./packages.nix
      ./hardware-configuration.nix
    ];

  # Compress for btrfs
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
  };

  boot.initrd.luks.devices."luks-1c5795c5-5459-4fb6-81af-d897254a77b4" = {
    allowDiscards = true;
    bypassWorkqueues = true;
  };

  services.udisks2.settings."udisks2.conf" = {
    Encryption = {
      Options = "allow-discards";
    };
  };
}

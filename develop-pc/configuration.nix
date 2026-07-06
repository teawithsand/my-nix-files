{ pkgs, lib, ... }:
{
  imports =
    [
      ../modules/common
      ../modules/hardware/asus.nix
      ../modules/hardware/displaylink.nix
      ../modules/hardware/nvidia-prime.nix
      ../modules/user-gming.nix
      ../modules/ssd.nix
      ./packages.nix
      ./hardware-configuration.nix
    ];

  boot.initrd.luks.devices."luks-de544881-2897-42b9-a196-82c0deede50a" = {
    allowDiscards = true;
    bypassWorkqueues = true;
  };

  services.udisks2.settings."udisks2.conf" = {
    Encryption = {
      Options = "allow-discards";
    };
  };
}

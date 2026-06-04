{ lib, ... }:
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
}

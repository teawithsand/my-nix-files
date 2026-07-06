{ lib, ... }:
{
  imports =
    [
      ../modules/common
      ../modules/hardware/displaylink.nix
      ../modules/ssd.nix
      ./machine.nix
      ./packages.nix
      ./hardware-configuration.nix
    ];
}

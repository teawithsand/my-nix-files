{ lib, ... }:
{
  imports =
    [
      ../modules/common
      ../modules/hardware/displaylink.nix
      ./machine.nix
      ./packages.nix
      ./hardware-configuration.nix
    ];
}

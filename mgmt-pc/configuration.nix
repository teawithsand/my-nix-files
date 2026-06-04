{ lib, ... }:
{
  imports =
    [
      ../modules/common
      ../modules/hardware/asus.nix
      ../modules/hardware/displaylink.nix
      ./machine.nix
      ./packages.nix
    ]
    ++ lib.optional (builtins.pathExists ./hardware-configuration.nix) ./hardware-configuration.nix;
}

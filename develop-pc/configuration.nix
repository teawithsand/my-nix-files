{ lib, ... }:
{
  imports =
    [
      ../modules/common
      ../modules/hardware/asus.nix
      ../modules/hardware/displaylink.nix
      ../modules/hardware/nvidia-prime.nix
      ./packages.nix
    ]
    ++ lib.optional (builtins.pathExists ./hardware-configuration.nix) ./hardware-configuration.nix;
}

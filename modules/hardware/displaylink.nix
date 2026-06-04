{ config, lib, pkgs, ... }:
{
  services.xserver.videoDrivers = lib.mkAfter [ "displaylink" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.evdi ];
  boot.initrd.kernelModules = [ "evdi" ];

  environment.systemPackages = with pkgs; [
    displaylink
  ];

  systemd.services.dlm.wantedBy = [ "multi-user.target" ];
}

{ config, lib, pkgs, ... }:
{

  nixpkgs.overlays = [
    (self: super: {
      displaylink = super.displaylink.overrideAttrs (old: {
        src = super.fetchurl {
          url = "https://www.synaptics.com/sites/default/files/exe_files/2025-09/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu6.2-EXE.zip";
          name = "displaylink-620.zip";
          sha256 = "10b9rgxc75x7qfp7h2pc4wmpi56b5v9gc9qpj87xm9gq9iwbn0r5";
        };
      });
    })
  ];

  nixpkgs.config.allowUnfree = true;
  
  services.xserver.videoDrivers = lib.mkAfter [ "displaylink" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.evdi ];
  boot.initrd.kernelModules = [ "evdi" ];

  environment.systemPackages = with pkgs; [
    displaylink
  ];

  systemd.services.dlm.wantedBy = [ "multi-user.target" ];
}

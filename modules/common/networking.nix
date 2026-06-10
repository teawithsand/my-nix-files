{ pkgs, lib, ... }:
{
  networking.hostName = "nixos";
  networking.nat = {
    enable = true;
    internalInterfaces = [ "ve-+" ];
  };

  # Grant wpa_supplicant access to certs, so wfi networks with these certs work fine.
  systemd.services.wpa_supplicant.serviceConfig = {
    ProtectHome = lib.mkForce "tmpfs";
    BindReadOnlyPaths = lib.mkAfter [ "/home/jan/Documents/certs" ];
  };

  networking.networkmanager = {
    enable = true;
    wifi.scanRandMacAddress = true;
    settings = {
      connection."wifi.mac-address-randomization" = "1";
      connection."ipv4.ignore-auto-dns" = "yes";
      connection."ipv6.ignore-auto-dns" = "yes";
      device."wifi.scan-rand-mac-address" = "yes";
    };
    plugins = with pkgs; [ networkmanager-openvpn ];
  };

  services.dbus.packages = with pkgs; [
    networkmanager-openvpn
  ];

  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSSEC = "true";
      Domains = [ "~." ];
      DNSOverTLS = "true";
      FallbackDNS = [
        "1.1.1.1#one.one.one.one"
        "1.0.0.1#one.one.one.one"
      ];
    };
  };

  networking.nameservers = [
    "1.1.1.1#one.one.one.one"
    "1.0.0.1#one.one.one.one"
  ];

  networking.firewall = {
    enable = true;
    allowPing = true;
    allowedTCPPorts = [
      4242
      4245
    ];
    allowedUDPPorts = [
      4242
      4245
    ];
  };
}

{
  imports = [
    ./base.nix
    ./networking.nix
    ./desktop.nix
    ./user-jan.nix
    ./packages.nix
    ./containers.nix
    ./docker-nerdctl.nix
    ./ssh-gpg.nix
    ./ssh-server-off.nix
    ./yubikey.nix
    ./disk-monitor.nix
  ];
}

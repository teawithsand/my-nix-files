{
  imports = [
    ./base.nix
    ./networking.nix
    ./desktop.nix
    ./users.nix
    ./packages.nix
    ./containers.nix
    ./docker-nerdctl.nix
    ./ssh-gpg.nix
    ./ssh-server-off.nix
    ./yubikey.nix
  ];
}

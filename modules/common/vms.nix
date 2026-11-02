{ pkgs, ... }:
{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };

  programs.virt-manager.enable = true;
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    qemu
    gnome-boxes
    virt-manager
    libvirt
    swtpm
    virtiofsd
  ];
}

{ pkgs, ... }:
{
  users.users.jan = {
    isNormalUser = true;
    description = "jan";
    extraGroups = [ "networkmanager" "wheel" "docker" "containerd" "camera" ];
    packages = with pkgs; [
    ];
  };

  users.groups.libvirtd.members = [ "jan" ];
  users.groups.kvm.members = [ "jan" ];
}

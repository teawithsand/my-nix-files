{ pkgs, ... }:
{
  users.users.jan = {
    isNormalUser = true;
    description = "jan";
    extraGroups = [ "networkmanager" "wheel" "docker" "containerd" ];
    packages = with pkgs; [
      thunderbird
      vscode
      blender
    ];
  };

  users.groups.libvirtd.members = [ "jan" ];
  users.groups.kvm.members = [ "jan" ];
}

{ pkgs, ... }:
{
  users.users.jan = {
    isNormalUser = true;
    description = "jan";
    extraGroups = [ "networkmanager" "wheel" "docker" "containerd" "camera" ];
    packages = with pkgs; [
      thunderbird
      vscode
      blender
      steam-run
      steamcmd
      xonotic
    ];
  };

  users.groups.libvirtd.members = [ "jan" ];
  users.groups.kvm.members = [ "jan" ];
}

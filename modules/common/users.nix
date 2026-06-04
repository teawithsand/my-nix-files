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

  users.users.gming = {
    isNormalUser = true;
    description = "gming";
    packages = with pkgs; [
      steam-run
      steamcmd
      xonotic
    ];
  };

  users.groups.libvirtd.members = [ "jan" ];
  users.groups.kvm.members = [ "jan" ];
}

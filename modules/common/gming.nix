{ pkgs, ... }:
{
    users.users.gming = {
        isNormalUser = true;
        description = "gming";
        packages = with pkgs; [
            steam-run
            steamcmd
            xonotic
        ];
    };
}
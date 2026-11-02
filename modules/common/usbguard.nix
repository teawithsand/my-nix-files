{ ... }:
{
    services.usbguard = {
        enable = true;
        presentDevicePolicy = "allow";
        implicitPolicyTarget = "block";
        
        # Note: it turns out that keyboards can identify as 03:00:00 or other and still hack me...
        # this is kind of bad
        rules = ''
            # block mouse
            block id *:* with-interface { 03:01:01 }
            # block keyboard
            block id *:* with-interface { 03:01:02 }
            # straight reject hid + mass device
            reject with-interface all-of { 08:*:* 03:*:* }

            allow
        '';
    };
    services.usbguard.IPCAllowedGroups = [ "wheel" ];
    environment.systemPackages = with pkgs; [
        usbguard
    ];
}
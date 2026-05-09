# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ./containers/projects/tws-lib-collection.nix
      # <home-manager/nixos>
    ];

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxPackages_6_18;
  boot.kernelModules = [ "ecryptfs" ];
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.kernel.sysctl = {
    "kernel.sysrq" = 502;
    "net.ipv4.ip_forward" = 1;
    "net.ipv4.conf.all.forwarding" = 1;
    "net.ipv4.conf.default.forwarding" = 1;
  };
  # boot.kernelParams = [ "acpi_backlight=native" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.nat = {
    enable = true;
    internalInterfaces = ["ve-+"];
  };


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["amdgpu" "nvidia" "displaylink"];
  boot.extraModulePackages = [ config.boot.kernelPackages.evdi ];
  boot.initrd = {
    # List of modules that are always loaded by the initrd.
    kernelModules = [
      "evdi"
    ];
  };

  # Enable networking
  networking.networkmanager = {
    enable = true;
    wifi.scanRandMacAddress = true;
    settings = {
      # this becomes the [connection] section in NetworkManager.conf
      connection."wifi.mac-address-randomization" = "1";
      connection."ipv4.ignore-auto-dns" = "yes";
      connection."ipv6.ignore-auto-dns" = "yes";

      # if you want additional NM defaults:
      # main."dns" = "systemd-resolved";
      device."wifi.scan-rand-mac-address" = "yes";
    };
    plugins = with pkgs; [ networkmanager-openvpn ];
  };

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;


  #environment.sessionVariables = {
  #  ELECTRON_OZONE_PLATFORM_HINT = "x11";
  #  GDK_BACKEND = "x11";
  #};

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "pl2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with 'passwd'.
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

  programs.steam.enable = true;

  users.users.gming = {
    isNormalUser = true;
    description = "gming";
    packages = with pkgs; [
      steam-run
      steamcmd
    ];
  };
 #home-manager.users.jan = {
 #   dconf.settings = {
 #     "org/gnome/desktop/background" = {
 #       picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
 #     };
 #     "org/gnome/desktop/interface" = {
 #       color-scheme = "prefer-dark";
 #     };
 #   };
 #
 #   gtk = {
 #     enable = true;
 #     theme = {
 #       name = "Adwaita-dark";
 #       package = pkgs.gnome-themes-extra;
 #     };
 #   };

    # Wayland, X, etc. support for session vars
#    systemd.user.sessionVariables = config.home-manager.users.jan.home.sessionVariables;
#    home.stateVersion = "26.05";
#  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  services.gnome.gcr-ssh-agent.enable = false;

  programs.ssh.startAgent = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = false;
  };


  # Nerd Fonts configuration
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.meslo-lg
  ];
  
  #virtualisation.virtualbox.host.enableExtensionPack = true;
  #virtualisation.virtualbox.host.enable = true;
  #virtualisation.virtualbox.guest.enable = true;
  #virtualisation.virtualbox.guest.dragAndDrop = true;
  # users.extraGroups.vboxusers.members = [ "jan" ];
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "jan" ];
  users.groups.kvm.members = [ "jan" ];


  services.dbus.packages = with pkgs; [
    networkmanager-openvpn
  ];


  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    # cnijfilter2
    # rg
    # yubioath-flutter
    buildkit
    efibootmgr
    kopia
    cloud-utils
    e2fsprogs
    nerdctl
    containerd
    kata-runtime
    cloud-hypervisor
    cni-plugins
    # kopia-ui # broken as of 15.04.2026
    libisoburn
    yubikey-manager
    whois
    gimp2
    mc
    mitmproxy
    cmake
    gcc15
    gdb
    nasm
    jq
    dnsmasq
    phodav
    gnome-boxes
    zenmap
    networkmanager-openvpn
    p7zip
    distrobox
    remmina
    x2goclient
    openvpn
    nmap
    killall
    virt-manager
    libvirt
    qemu
    xsane
    simple-scan
    file
    net-tools
    wget
    git
    displaylink
    dislocker
    ungoogled-chromium
    ffmpeg_7-full
    obs-studio
    pv
    zstd
    pigz
    gnutar
    yubikey-manager
    kitty
    #kitty-themes
    #android-tools
    python313
    python313Packages.ipython
    ecryptfs
    nix-index
    pciutils
    lshw
    # gnome-network-displays
    iw
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-vaapi
    gst_all_1.gst-libav
    dig
    libreoffice
    wireshark
    v4l-utils
    signal-desktop
    mtr
    traceroute
    iotop
    tcpdump
    #tor-browser
  ];

  programs.nix-ld.enable = true;

  virtualisation.docker = {
    enable = true;
    # enableNvidia = true;
  };

  # virtualisation.containerd.enable = true;

  virtualisation.containerd = {
    enable = true;
    
    settings = {
      version = 2;

      plugins."io.containerd.grpc.v1.cri".containerd = {
        default_runtime_name = "kata";
        runtimes.kata = {
          runtime_type = "io.containerd.kata.v2";
        };
        runtimes.runc = {
          runtime_type = "io.containerd.runc.v2";
        };
      };
    };
  };

  environment.shellAliases = {
    nerdctl-kata = "nerdctl --runtime io.containerd.kata.v2";
  };

 
  hardware.nvidia-container-toolkit.enable = true;
  virtualisation.containers.enable = true;
  virtualisation.docker.daemon.settings.features.cdi = true;

  # environment.etc."kata-containers/configuration.toml".source = "${pkgs.kata-runtime}/share/defaults/kata-containers/configuration-clh.toml";
  environment.etc."kata-containers/configuration-clh.toml".source =
  pkgs.runCommand "kata-clh-config" {} ''
    substitute ${pkgs.kata-runtime}/share/defaults/kata-containers/configuration-clh.toml $out \
      --replace-fail ${pkgs.kata-runtime}/bin/cloud-hypervisor ${pkgs.cloud-hypervisor}/bin/cloud-hypervisor
  '';

  systemd.services.containerd.path = with pkgs; [
    containerd
    runc
    kata-runtime
    cloud-hypervisor
    iptables
    cni-plugins
    util-linux
    coreutils
    gawk
    gnugrep
    gnused
  ];

  xdg.portal.enable = true;

  xdg.portal.xdgOpenUsePortal = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-gnome
    #pkgs.xdg-desktop-portal-wlr
  ];

  # Display link service
  systemd.services.dlm.wantedBy = [ "multi-user.target" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    dnsovertls = "true";
    fallbackDns = [
      "1.1.1.1#one.one.one.one"
      "1.0.0.1#one.one.one.one"
    ];
  };
  networking.nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];

  services.udev.packages = [ pkgs.yubikey-personalization ];

  systemd.services.buildkit = {
    description = "BuildKit daemon";
    after = [ "network.target" "containerd.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.buildkit}/bin/buildkitd";
      Restart = "always";
    };
  };
  
  services.supergfxd.enable = true;
  systemd.services.supergfxd.path = [ pkgs.pciutils ];
  services = {
    asusd = {
      enable = true;
      enableUserService = true;
    };
  };
  services.pcscd.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = false;

  # networking.firewall.trustedInterfaces = [ "p2p-wl+" ];
  #networking.firewall.allowPing = true;
  #networking.firewall.allowedTCPPorts = [ 4242 4245 3478 ];
  #networking.firewall.allowedUDPPorts = [ 4242 4245 3478 ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  #networking.firewall.enable = true;

  networking.firewall = {
    enable = true;
    allowPing = true;

    allowedTCPPorts = [
      4242
      4245
      3478
      5349
    ];

    allowedUDPPorts = [
      4242
      4245
      3478
    ];

    # Relay range for WebRTC/TURN
    allowedUDPPortRanges = [
      { from = 49160; to = 49200; }
    ];

    # TCP relays for WebRTC/TURN
    allowedTCPPortRanges = [
      { from = 49160; to = 49200; }
    ];
  };

  security.polkit.enable = true;
  # services.containerd.enable = true;

  # graphics
  hardware.graphics = {
    enable = true;
  };

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = true;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      # sync.enable = false;

      # reverseSync.enable = true;
      # Enable if using an external GPU
      # allowExternalGpu = false;

      # Make sure to use the correct Bus ID values for your system!
      amdgpuBusId = "PCI:54:00:0";
      nvidiaBusId = "PCI:01:00:0";
    };
  };
  

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}

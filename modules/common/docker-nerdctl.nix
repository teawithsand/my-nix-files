{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    buildkit
    nerdctl
    containerd
    kata-runtime
    cloud-hypervisor
    cni-plugins
  ];

  virtualisation.docker.enable = true;
  virtualisation.containers.enable = true;

  virtualisation.containerd = {
    enable = true;
    settings = {
      version = 2;
      plugins."io.containerd.grpc.v1.cri".containerd = {
        default_runtime_name = "kata";
        runtimes = {
          kata = {
            runtime_type = "io.containerd.kata.v2";
            options = {
              ConfigPath = "/etc/kata-containers/configuration-clh.toml";
            };
          };
          runc = {
            runtime_type = "io.containerd.runc.v2";
          };
        };
      };
    };
  };

  environment.etc."kata-containers/configuration-clh.toml".source =
    pkgs.runCommand "kata-clh-config" { } ''
      substitute ${pkgs.kata-runtime}/share/defaults/kata-containers/configuration-clh.toml $out \
        --replace-fail ${pkgs.kata-runtime}/bin/cloud-hypervisor ${pkgs.cloud-hypervisor}/bin/cloud-hypervisor
    '';

  # HACK: replace main configuration with this one, I guess for overriding qemu it will be fine
  environment.etc."kata-containers/configuration.toml".source = "/etc/kata-containers/configuration-clh.toml";

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

  systemd.services.buildkit = {
    description = "BuildKit daemon";
    after = [ "network.target" "containerd.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.buildkit}/bin/buildkitd";
      Restart = "always";
    };
  };
}

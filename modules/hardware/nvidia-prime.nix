{ config, lib, pkgs, ... }:
{
  services.xserver.videoDrivers = lib.mkAfter [
    "amdgpu"
    "nvidia"
  ];

  environment.systemPackages = with pkgs; [
    nvidia-container-toolkit
    nvidia-docker
    libnvidia-container
  ];

  virtualisation.containerd.settings.plugins."io.containerd.grpc.v1.cri".containerd.runtimes.nvidia = {
    runtime_type = "io.containerd.runc.v2";
    options = {
      BinaryName = "/run/current-system/sw/bin/nvidia-container-runtime";
    };
  };

  # Makes CI/CD simpler
  hardware.nvidia-container-toolkit.suppressNvidiaDriverAssertion = true;
  hardware.nvidia-container-toolkit.enable = true;
  virtualisation.docker.daemon.settings.features.cdi = true;

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      amdgpuBusId = "PCI:54:00:0";
      nvidiaBusId = "PCI:01:00:0";
    };
  };
}

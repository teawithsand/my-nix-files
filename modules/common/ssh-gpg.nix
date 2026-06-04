{
  services.gnome.gcr-ssh-agent.enable = false;

  programs.ssh.startAgent = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = false;
  };
}

{
  services.gnome.gcr-ssh-agent.enable = false;
  programs.ssh.startAgent = false;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}

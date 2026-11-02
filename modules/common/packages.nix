{ pkgs, ... }:
{
	programs.firefox.enable = true;

	environment.systemPackages = with pkgs; [
		ungoogled-chromium
		vscodium
		lm_sensors
		iptables
		efibootmgr
		kopia
		keepassxc
		dnsmasq
		openvpn
		nmap
		psmisc
		net-tools
		wget
		curl
		git
		pv
		zstd
		pigz
		gnutar
		kitty
		python313
		python313Packages.ipython
		pciutils
		lshw
		iw
		dig
		traceroute
		tcpdump
		gocryptfs
	];
	programs.firefox.nativeMessagingHosts.packages = [ pkgs.keepassxc ];
}

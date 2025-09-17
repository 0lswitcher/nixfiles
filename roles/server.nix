
#   ███████╗███████╗██████╗ ██╗   ██╗███████╗██████╗      ██████╗ ██████╗ ███╗   ██╗███████╗
#   ██╔════╝██╔════╝██╔══██╗██║   ██║██╔════╝██╔══██╗    ██╔════╝██╔═══██╗████╗  ██║██╔════╝
#   ███████╗█████╗  ██████╔╝██║   ██║█████╗  ██████╔╝    ██║     ██║   ██║██╔██╗ ██║█████╗  
#   ╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██╔══╝  ██╔══██╗    ██║     ██║   ██║██║╚██╗██║██╔══╝  
#   ███████║███████╗██║  ██║ ╚████╔╝ ███████╗██║  ██║    ╚██████╗╚██████╔╝██║ ╚████║██║     
#   ╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝     ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     

{ config, pkgs, ... }:

# ░█▀█░█▀█░█▀▀░█░█░█▀█░█▀▀░█▀▀░█▀▀░░░░
# ░█▀▀░█▀█░█░░░█▀▄░█▀█░█░█░█▀▀░▀▀█░░▀░
# ░▀░░░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░░▀░

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # main packages block
  environment.systemPackages = with pkgs; [
    micro #--------------# text editor
    wget #---------------# world wide web get
    ranger #-------------# file browser
    unzip #--------------# CLI extraction tool
    ncdu #---------------# disk usage analyzer
    dysk #---------------# disk usage analyzer
    lsd #----------------# next gen ls
    nss_latest #---------# libs for server security
    openssl #------------# lib for SSL and TLS protocols
    btop #---------------# system resource monitor
  ];

# ░█▀█░█▀▄░█▀█░█▀▀░█▀▄░█▀█░█▄█░█▀▀░░░░
# ░█▀▀░█▀▄░█░█░█░█░█▀▄░█▀█░█░█░▀▀█░░▀░
# ░▀░░░▀░▀░▀▀▀░▀▀▀░▀░▀░▀░▀░▀░▀░▀▀▀░░▀░

  # enable exec of unpatched dynamic binaries via shim layer
  # ( bridge expected dirs for packages that expect them )
  programs.nix-ld.enable = true;

# ░█▀▀░█▀▀░█▀▄░█░█░▀█▀░█▀▀░█▀▀░█▀▀░░░░
# ░▀▀█░█▀▀░█▀▄░▀▄▀░░█░░█░░░█▀▀░▀▀█░░▀░
# ░▀▀▀░▀▀▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░░▀░
 
  # enable the OpenSSH daemon
  services.openssh = {
  	enable = true;
  	ports = [ 0000 ]; # change me!
  	settings = {
  		PermitRootLogin = "no";
  		PasswordAuthentication = false; 
  		AllowUsers = [ "changeme" ];
  	};
  	allowSFTP = false;
  };


  # enable the fail2ban daemon (ban failed auth ip's)
  services.fail2ban = {
  	enable = true;
  	maxretry = 3;
  	bantime = "24h";
  	 
  	ignoreIP = [
  	# whitelisted subnets
      "127.0.0.1/8"       # localhost loopback
  	  "192.168.254.0/24"  # lan ip
  	  "10.0.0.0/8"        # docker & internal networks
  	  "172.16.0.0/12"     # more docker bridge subnets
  	];
  	 
    jails = {
      sshd.settings = {
	    enable = true;
	    filter = "sshd";
	    backend = "systemd";
        findtime = "10m";
      };
    };
  };

# ░█▀▄░█▀█░█▀▀░█░█░█▀▀░█▀▄░░░░
# ░█░█░█░█░█░░░█▀▄░█▀▀░█▀▄░░▀░
# ░▀▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀░░▀░

  virtualisation.docker = {
  	enable = true;
  	rootless.enable = true;
  	rootless.setSocketVariable = true;
  };

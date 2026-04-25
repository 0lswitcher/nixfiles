
#       ███╗   ██╗██╗██╗  ██╗ ██████╗ ███████╗     ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ 
#       ████╗  ██║██║╚██╗██╔╝██╔═══██╗██╔════╝    ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ 
#       ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║███████╗    ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
#       ██║╚██╗██║██║ ██╔██╗ ██║   ██║╚════██║    ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
#       ██║ ╚████║██║██╔╝ ██╗╚██████╔╝███████║    ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
#       ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝     ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ 

                             # Smith (Halftop Headless Server}

{ config, pkgs, ... }:

{
  imports =
    [ # include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
    
# nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

# ░█▀▄░█▀█░█▀█░▀█▀░░░░
# ░█▀▄░█░█░█░█░░█░░░▀░
# ░▀▀░░▀▀▀░▀▀▀░░▀░░░▀░

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 1;
  boot.kernelParams = [ "random.trust_cpu=on" ];  
  boot.initrd.systemd.tpm2.enable = false;
  systemd.tpm2.enable = false;

  networking.hostName = "smith";
  # networking.wireless.enable = true;  # enables wireless support via wpa_supplicant.

  # configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # enable networking
  networking.networkmanager.enable = true;

  # add domains to host file
  networking.extraHosts = ''
    127.0.0.1 smith.lan
  '';
  
  # enable ram compression to swap
  zramSwap.enable = true;

  # configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };


# ░█░█░█▀▀░█▀▀░█▀▄░░░░
# ░█░█░▀▀█░█▀▀░█▀▄░░▀░
# ░▀▀▀░▀▀▀░▀▀▀░▀░▀░░▀░

  # define a user account
  users.users.y2k = {
    isNormalUser = true;
    description = "y2k";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFuQacRqrO0sO3z6kURd3cHHEurzU3vhH460N+iBmQPj neo64" ];
    packages = with pkgs; [];
  };
  
  # set time zone.
  time.timeZone = "America/New_York";

  # select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # fonts
  fonts.packages = with pkgs; [
  	nerd-fonts.hack
  ];

# ░█▀█░█▀█░█▀▀░█░█░█▀█░█▀▀░█▀▀░█▀▀░░░░
# ░█▀▀░█▀█░█░░░█▀▄░█▀█░█░█░█▀▀░▀▀█░░▀░
# ░▀░░░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░░▀░

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # main packages block
  environment.systemPackages = with pkgs; [
    git #----------------# version control
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

  # programs:

  # enable exec of unpatched dynamic binaries via shim layer
  # ( bridge expected dirs for packages that expect them )
  programs.nix-ld.enable = true;

  # services:
  
  # enable the OpenSSH daemon
  services.openssh = {
  	enable = true;
  	ports = [ 59833 ];
  	settings = {
  		PermitRootLogin = "no";
  		PasswordAuthentication = false; 
  		AllowUsers = [ "y2k" ];
  	};
  	allowSFTP = true;
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


  # open ports in the firewall
  networking.firewall.trustedInterfaces = [ "wg0" ];
  networking.firewall.allowedTCPPorts = [
   59833 # ssh
#     80 # http          
#    443 # https     
#  57116 # traefik ui
#  47179 # traefik http  
#  25674 # traefik https  
#   8080 # nginx http    # N #
#   8443 # nginx https   # P #
#   8181 # nginx ui      # M #
    8890 # komodo
    5001 # dockge
   61208 # glances
   15725 # dozzle
   60921 # it-tools
   19217 # vscode
   24242 # microbin
    5173 # grimoire
    3000 # docmost
   13695 # lubelog
   64685 # beszel hub
   35325 # beszel agent (Smith)
   15637 # beszel agent (Oracle)
   44478 # convertx
   13932 # cup
   52380 # spotistats client
   54870 # spotistats api
   13097 # quantum
   48483 # glance
    2308 # lunalytics
   26889 # scrutiny (webapp)
   32514 # scrutiny (influxDB admin)
   50298 # drawio (http)
   61842 # drawio (https)
   54135 # speedtest tracker (http)
   49230 # speedtest tracker (https)
   42050 # linkwarden
   42051 # vaultwarden
   30123 # ntfy
    6875 # bookstack
   56672 # caddy http
   56673 # caddy https
   42627 # freshrss
   22336 # grist
   29673 # pxls # NTB FIXED!!
   53872 # monicaCRM
    9640 # dumbpad
    9641 # dumbkan
    5673 # urocissa
   52805 # komodo Oracle periphery
    8384 # syncthing web ui
   22000 # syncthing TCP
  ];
   networking.firewall.allowedUDPPorts = [ 
   22000 # syncthing QUIC
   21027 # syncthing local discovery
  ];

#  # port redirection ( 80 to 8080, and 443 to 8443 )
#  networking.nftables.ruleset = ''
#    table ip nat {
#      chain prerouting {
#        type nat hook prerouting priority dstnat;
#        tcp dport 80 redirect to :8080
#        tcp dport 443 redirect to :8443
#      }
#    }
#  '';

  # docker management
  virtualisation.docker = {
  	enable = true;
  	rootless.enable = true;
  	rootless.setSocketVariable = true;
  };

  # leave as initial installation version
  system.stateVersion = "25.05"; # Did you read the comment?

}

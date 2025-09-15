
#       ███╗   ██╗██╗██╗  ██╗ ██████╗ ███████╗     ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ 
#       ████╗  ██║██║╚██╗██╔╝██╔═══██╗██╔════╝    ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ 
#       ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║███████╗    ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
#       ██║╚██╗██║██║ ██╔██╗ ██║   ██║╚════██║    ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
#       ██║ ╚████║██║██╔╝ ██╗╚██████╔╝███████║    ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
#       ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝     ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ 

                                   # Oracle (Workhorse PC)

{ config, lib, pkgs, ... }:

{
  imports =
    [ # include the results of the hardware scan
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

# ░█▀▄░█▀█░█▀█░▀█▀░░░░
# ░█▀▄░█░█░█░█░░█░░░▀░
# ░▀▀░░▀▀▀░▀▀▀░░▀░░░▀░

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 1;
  boot.kernelParams = [ "random.trust_cpu=on" ];
  
  # ensure latest linux kernel is installed (disabled for nvidia drivers)
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "oracle";
  networking.networkmanager.enable = true;
# networking.wireless.enable = true;  # alt wireless support via wpa_supplicant
  networking.extraHosts = ''
    192.168.254.130 smith.lan
  '';

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# ░█░█░█▀█░█▀▄░█▀▄░█░█░█▀█░█▀▄░█▀▀░░░░
# ░█▀█░█▀█░█▀▄░█░█░█▄█░█▀█░█▀▄░█▀▀░░▀░
# ░▀░▀░▀░▀░▀░▀░▀▀░░▀░▀░▀░▀░▀░▀░▀▀▀░░▀░

  # enable sound
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # enable opengl
  hardware.graphics = {
    enable = true;
  };

  # load nvidia driver for xorg and wayland
  services.xserver.videoDrivers = ["nvidia"];
  # configure nvidia
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false; # turns of gpu when not being used
    open = true;
    nvidiaSettings = true; # accessible via 'nvidia-settings'
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.bluetooth.enable = true; # enables support for bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default bluetooth controller on boot

  # enable OpenTabletDriver
  # hardware.opentabletdriver.enable = true;

# ░█░█░█▀▀░█▀▀░█▀▄░░░░
# ░█░█░▀▀█░█▀▀░█▀▄░░▀░
# ░▀▀▀░▀▀▀░▀▀▀░▀░▀░░▀░

  # define user account
  users.users = {
    y2k = {
     initialPassword = "temp";
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" "audio" "video" "docker" ]; # sudo, the rest are self expl.
     packages = with pkgs; [];
   };
  };

  # adding y2k to wheel wasn't enough so...voilà
  security.sudo.configFile = "y2k ALL=(ALL:ALL) SETENV: ALL";

  # set the time zone (wrong place, right time)
  time.timeZone = "America/Winnipeg";

# ░█▀▀░█▀█░█▀█░▀█▀░█▀▀░░░░
# ░█▀▀░█░█░█░█░░█░░▀▀█░░▀░
# ░▀░░░▀▀▀░▀░▀░░▀░░▀▀▀░░▀░

  fonts.packages = with pkgs; [
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
  ];

# ░█▀█░█▀█░█▀▀░█░█░█▀█░█▀▀░█▀▀░█▀▀░░░░
# ░█▀▀░█▀█░█░░░█▀▄░█▀█░█░█░█▀▀░▀▀█░░▀░
# ░▀░░░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░░▀░

  nixpkgs.config = {
    allowUnfree = true;
    nvidia.acceptLicense = true; 
    permittedInsecurePackages = [
    	"ventoy-1.1.05"
    ];
  };

  # system pkgs
  environment.systemPackages = with pkgs; [


                    # main
    foot #---------------------------------# terminal
    micro #--------------------------------# text editor
    vscodium #-----------------------------# text editor
    obsidian #-----------------------------# note taking
    firefox #------------------------------# web browser
    feh #----------------------------------# image viewer
    mpv #----------------------------------# media player
    btop #---------------------------------# resource manager   
    ncspot #-------------------------------# TUI music player
    qalculate-qt #-------------------------# calculator
    ventoy-full #--------------------------# create bootable USB's
    vesktop #------------------------------# discord alternative
    ulauncher #----------------------------# search & run programs
    git #----------------------------------# version control sys
    wget #---------------------------------# world wide web get
    fzf #----------------------------------# fuzzy finder
    jq #-----------------------------------# JSON processor    
    socat #--------------------------------# SOcket CAT
    killall #------------------------------# process termination
    thefuck #------------------------------# command correction

                  # gaming
    mangohud #-----------------------------# performance monitor
    protonup-qt #--------------------------# compatability layer
    heroic #-------------------------------# compatability layer
    prismlauncher #------------------------# minecraft launcher

                  # storage
    ranger #-------------------------------# CLI file manager
    lxqt.pcmanfm-qt #----------------------# file manager
    file-roller #--------------------------# GUI extraction tool
    unzip #--------------------------------# CLI extraction tool             
    ncdu #---------------------------------# disk usage analyzer
    dysk #---------------------------------# disk usage analyzer   
    usbutils #-----------------------------# usb tools
    udiskie #------------------------------# disk automounter           
    udisks #-------------------------------# storage daemon
    lsd #----------------------------------# next gen ls

                    # fun
    astroterm #----------------------------# celestial viewer
    pipes #--------------------------------# terminal screensaver
    lolcat #-------------------------------# rainbow echo
    fastfetch #----------------------------# system information

             # desktop environment
    swww #---------------------------------# wallpaper daemon
    waypaper #-----------------------------# GUI wallpaper setter
    waybar #-------------------------------# status bar
    hyprpicker #---------------------------# color picker
    hyprshot #-----------------------------# screenshot utility
    hyprpolkitagent #----------------------# authentication daemon
    swaynotificationcenter #---------------# notification daemon

             # hardware management
    lshw #---------------------------------# ls for hardware
    bluez #--------------------------------# bluetooth protocol stack
    bluetui #------------------------------# tui bluetooth manager
    brightnessctl #------------------------# self explanatory
    wdisplays #----------------------------# GUI display manager
 #  opentabletdriver #---------------------# tablet management
 #  openrgb #------------------------------# FOSS rgb control
    via #----------------------------------# keyboard configurator
    pavucontrol #--------------------------# audio management
 
                 # theming
    nwg-look #-----------------------------# GUI GTK theming          
    kdePackages.qt6ct #--------------------# GUI Qt theming            
    kdePackages.qtwayland #----------------# wayland Qt plugin         
    kdePackages.breeze #-------------------# breeze Qt theme            
    kdePackages.breeze-gtk #---------------# breeze GTK theme          
    kdePackages.breeze-icons #-------------# breeze icons
    adwaita-qt6 #--------------------------# adwaita theme
    spicetify-cli #------------------------# CLI spotify theming
    pastel #-------------------------------# CLI color tool
    pywal #--------------------------------# colorschemes manager
    pywalfox-native #----------------------# pywal firefox plugin
    gowall #-------------------------------# convert wallpaper to theme

           # dependencies & portals
    egl-wayland #--------------------------# backend for wayland
    glm #----------------------------------# dependancy for hyprgrass
    libnotify #----------------------------# dependancy for swaync 
    gtk3 #---------------------------------# GUI toolkit for GTK3     
    xdg-desktop-portal-gtk #---------------# backend for GTK apps
    xdg-desktop-portal-hyprland #----------# backend for hyprland
    kdePackages.xdg-desktop-portal-kde #---# backend for Qt/KDE apps
  ];

# ░█▀█░█▀▄░█▀█░█▀▀░█▀▄░█▀█░█▄█░█▀▀░░░░
# ░█▀▀░█▀▄░█░█░█░█░█▀▄░█▀█░█░█░▀▀█░░▀░
# ░▀░░░▀░▀░▀▀▀░▀▀▀░▀░▀░▀░▀░▀░▀░▀▀▀░░▀░

  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  # Some programs need SUID wrappers, can be configured further or are started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

# ░█▀▀░█▀▀░█▀▄░█░█░▀█▀░█▀▀░█▀▀░█▀▀░░░░
# ░▀▀█░█▀▀░█▀▄░▀▄▀░░█░░█░░░█▀▀░▀▀█░░▀░
# ░▀▀▀░▀▀▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░░▀░

  # set maximum systemd log file size
  services.journald.extraConfig = "SystemMaxUse=50M";

  # disable wait for connection to boot
  systemd.services.NetworkManager-wait-online.enable = false;

  # enable greetd w tuigreet frontend
  services.greetd.enable = true;
  services.greetd.settings = {
    default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --greeting '

▓█████▄ ▓█████ ▓█████▄   ██████ ▓█████  ▄████▄  
▒██▀ ██▌▓█   ▀ ▒██▀ ██▌▒██    ▒ ▓█   ▀ ▒██▀ ▀█  
░██   █▌▒███   ░██   █▌░ ▓██▄   ▒███   ▒▓█    ▄ 
 ░▓█▄   ▌▒▓█  ▄ ░▓█▄   ▌  ▒   ██▒▒▓█  ▄ ▒▓▓▄ ▄██▒
 ░▒████▓ ░▒████▒░▒████▓ ▒██████▒▒░▒████▒▒ ▓███▀ ░
  ▒▒▓  ▒ ░░ ▒░ ░ ▒▒▓  ▒ ▒ ▒▓▒ ▒ ░░░ ▒░ ░░ ░▒ ▒  ░
░ ▒  ▒  ░ ░  ░ ░ ▒  ▒ ░ ░▒  ░ ░ ░ ░  ░  ░  ▒   
░ ░  ░    ░    ░ ░  ░ ░  ░  ░     ░   ░        
  ░       ░  ░   ░          ░     ░  ░░ ░      
░              ░                      ░        

' --remember --remember-session  --cmd hyprland";
      user = "greeter";
    };
  };

  # enable nvidia drivers
  # services.xserver.videoDrivers = ["nvidia"];

  # enable storage services
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # enable openrgb
  services.hardware.openrgb.enable = true;

  # enable CUPS to print documents
  # services.printing.enable = true;

  # enable flatpak (ik :/ it's just for spicetify)
  services.flatpak.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # enable the OpenSSH daemon
  # services.openssh.enable = true;

# ░█▀▀░▀█▀░█▀▄░█▀▀░█░█░█▀█░█░░░█░░░░░░
# ░█▀▀░░█░░█▀▄░█▀▀░█▄█░█▀█░█░░░█░░░░▀░
# ░▀░░░▀▀▀░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀▀▀░░▀░

  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "wg0" ];
    allowedTCPPorts = [
      47179 # traefik http
      25674 # traefik https
       5001 # dockge
      25565 # mc-server
      55555 # mc-lan
      52805 # komodo periphery (Host)
       8384 # syncthing web ui
      22000 # syncthing TCP
      42051 # vaultwarden (SSH tunnel port)
    ];
     allowedUDPPorts = [
      22000 # syncthing QUIC
      21027 # syncthing local discovery
    ];
  };


# ░█▀▄░█▀█░█▀▀░█░█░█▀▀░█▀▄░░░░
# ░█░█░█░█░█░░░█▀▄░█▀▀░█▀▄░░▀░
# ░▀▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀░░▀░

  virtualisation.docker = {
  	enable = true;
  	rootless.enable = true;
  };


# ░█▀█░▀█▀░█░█░█▀▀░█▀▄░░░░
# ░█░█░░█░░█▀█░█▀▀░█▀▄░░▀░
# ░▀▀▀░░▀░░▀░▀░▀▀▀░▀░▀░░▀░

  # desktop portal
  xdg.portal.enable = true;
  xdg.portal.config.common.default = "";
  xdg.portal.extraPortals = [
   pkgs.xdg-desktop-portal-gtk
   pkgs.xdg-desktop-portal-hyprland
   pkgs.kdePackages.xdg-desktop-portal-kde
  ];

  #gtk.enable = true;
  #qt.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  system.stateVersion = "24.11"; # leave ts alone

}

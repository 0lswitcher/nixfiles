
#      ███████╗██╗   ██╗██╗     ██╗         ██████╗ ██╗  ██╗ ██████╗ ███████╗
#      ██╔════╝██║   ██║██║     ██║         ██╔══██╗██║ ██╔╝██╔════╝ ██╔════╝
#      █████╗  ██║   ██║██║     ██║         ██████╔╝█████╔╝ ██║  ███╗███████╗
#      ██╔══╝  ██║   ██║██║     ██║         ██╔═══╝ ██╔═██╗ ██║   ██║╚════██║
#      ██║     ╚██████╔╝███████╗███████╗    ██║     ██║  ██╗╚██████╔╝███████║
#     ╚═╝      ╚═════╝ ╚══════╝╚══════╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚══════╝

{ config, pkgs, ... }:

{

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
    alacritty #----------------------------# terminal
    micro #--------------------------------# text editor
    vscodium #-----------------------------# IDE
    python3Full #--------------------------# python lang
    rustup #-------------------------------# rust lang
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
    nixos-generators #---------------------# generates custom ISOs

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
    unrar-free #---------------------------# CLI RAR extaction tool  
    unetbootin #---------------------------# bootable drive maker     
    cdrtools #-----------------------------# variety of cd,dvd, and boot tools     
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
    hyprpaper #----------------------------# wallpaper backend for waypaper
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
 #  wdisplays #----------------------------# GUI display manager
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
    clang #--------------------------------# c compiler / linker
    egl-wayland #--------------------------# backend for wayland
    glm #----------------------------------# dependancy for hyprgrass
    libnotify #----------------------------# dependancy for swaync 
    gtk3 #---------------------------------# GUI toolkit for GTK3     
    xdg-desktop-portal-gtk #---------------# backend for GTK apps
    xdg-desktop-portal-hyprland #----------# backend for hyprland
    kdePackages.xdg-desktop-portal-kde #---# backend for Qt/KDE apps
    python312Packages.textual #------------# TUI framework for python
    gettext #------------------------------# translation tools (envsubst for vintagestory)
    dotnetCorePackages.runtime_8_0-bin #---# .NET runtime 8 for vintagestory
    protontricks #-------------------------# proton features
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

  # enable openrgb
  services.hardware.openrgb.enable = true;


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
    NIXOS_OZONE_WL = "1"; # for vencord/vesktop and any other electron based pkgs
    PYTHONHISTFILE = "$HOME/.cache/.python_history"; # relocate file that tries to reside in $HOME
  };

}

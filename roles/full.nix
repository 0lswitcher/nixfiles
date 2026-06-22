
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
    	"electron-36.9.5"
    ];
  };

  # system pkgs
  environment.systemPackages = with pkgs; [


                    # main
#   foot #---------------------------------# terminal                        (installed via programs.foot.enable = true;)
    micro #--------------------------------# text editor
#   neovim #-------------------------------# vim fork                        (installed via programs.neovim.enable = true;)
    neovide #------------------------------# GUI for neovim
    vscodium #-----------------------------# IDE
    rustup #-------------------------------# rust lang
    obsidian #-----------------------------# note taking
#   firefox #------------------------------# web browser                     (installed via programs.firefox.enable = true;)
    feh #----------------------------------# image viewer
    mpv #----------------------------------# media player
    imagemagick #--------------------------# everything bitmap img
#    (blender.override { #------------------# 3D FOSS (with cuda support)    (commented out bc fuck the manual build times)
#        cudaSupport = true;
#    }) 
    btop #---------------------------------# resource manager   
    ncspot #-------------------------------# TUI music player
    qalculate-qt #-------------------------# calculator
    vesktop #------------------------------# discord alternative
    ripgrep #------------------------------# TSS + grep
    aria2 #--------------------------------# CLI IDM
    wget #---------------------------------# world wide web get
#   git #----------------------------------# version control system          (installed via programs.git.enable = true;)
    fzf #----------------------------------# fuzzy finder
    fd #-----------------------------------# find alternative
    jq #-----------------------------------# JSON processor
    socat #--------------------------------# SOcket CAT
    stow #---------------------------------# symlink farm manager
    killall #------------------------------# process termination
    tealdeer #-----------------------------# tldr - short man pages
    playerctl #----------------------------# music/media player controller
    nixos-generators #---------------------# generates custom ISOs

                 # music prod.
    reaper #-------------------------------# DAW
    helm #---------------------------------# synth plugin

                 # video prod.
    gpu-screen-recorder-gtk #--------------# self expl.                      (backend installed via programs.gpu-screen-recorder.enable = true;)
#   obs-studio #---------------------------# open brodcasting software       (installed via programs.obs-studio.enable = true;)
    kdePackages.kdenlive #-----------------# video editor

                  # gaming
#   steam #--------------------------------# game distribution platform      (installed via programs.steam.enable = true;)
    mangohud #-----------------------------# performance monitor
    protonup-qt #--------------------------# compatability layer
    heroic #-------------------------------# compatability layer
    prismlauncher #------------------------# minecraft launcher
    vkbasalt #-----------------------------# vulkan post processing layer

                  # storage
    ranger #-------------------------------# TUI file manager                (installed via programs.ranger.enable = true;)
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
    cava #---------------------------------# audio visualizer
    pipes #--------------------------------# terminal screensaver
    lolcat #-------------------------------# rainbow echo
    fastfetch #----------------------------# system information

             # desktop environment
#   hyprland #-----------------------------# tiling wayland compositor        (installed via programs.hyprland.enable = true;)
    awww #---------------------------------# wallpaper daemon                 (previously swww) 
    hyprpaper #----------------------------# wallpaper backend for waypaper
    waypaper #-----------------------------# GUI wallpaper setter
#   waybar #-------------------------------# status bar                       (installed via programs.waybar.enable = true;)
    waybar-lyric #-------------------------# lyric module for waybar
    kando #--------------------------------# pie menu
    ulauncher #----------------------------# search & run programs    
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
    via #----------------------------------# keyboard configurator
    pavucontrol #--------------------------# audio management
    oversteer #----------------------------# GUI Sim Config
    input-remapper #-----------------------# GUI keeb n mouse + gamepad mapping
    alvr #---------------------------------# VR link
    wivrn #--------------------------------# VR link
    android-tools #------------------------# required for ADB/Wired connection
    vulkan-loader #------------------------# loads vulkan extensions
    vulkan-validation-layers #-------------# self expl.
    vulkan-extension-layer #---------------# self expl.
#   opentabletdriver #---------------------# tablet management               (installed via programs.opentabletdrive.enable = true;)
#   openrgb #------------------------------# FOSS rgb control                (installed via programs.openrgb.enable = true;)
 
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
    clang #--------------------------------# c compiler / linker (for rustup)
    egl-wayland #--------------------------# backend for wayland
    wl-clipboard #-------------------------# wayland clipboard utils
    glm #----------------------------------# dependancy for hyprgrass
    libnotify #----------------------------# dependancy for swaync 
    gtk3 #---------------------------------# GUI toolkit for GTK3     
    xdg-user-dirs #------------------------# backend for user dirs
    xdg-desktop-portal-gtk #---------------# backend for GTK apps
    xdg-desktop-portal-hyprland #----------# backend for hyprland
    kdePackages.xdg-desktop-portal-kde #---# backend for Qt/KDE apps
    gettext #------------------------------# translation tools (envsubst for vintagestory)
    dotnetCorePackages.runtime_8_0-bin #---# .NET runtime 8 for vintagestory
    protontricks #-------------------------# proton features
    bc #-----------------------------------# GNU software calculator (for waybar > jvc84/wayves)
    deno #---------------------------------# secure runtime for JavaScript & TypeScript (dependancy for nvim markup plugin)
  ];

# ░█▀█░█▀▄░█▀█░█▀▀░█▀▄░█▀█░█▄█░█▀▀░░░░
# ░█▀▀░█▀▄░█░█░█░█░█▀▄░█▀█░█░█░▀▀█░░▀░
# ░▀░░░▀░▀░▀▀▀░▀▀▀░▀░▀░▀░▀░▀░▀░▀▀▀░░▀░

  programs.dconf.enable = true; #-----------------# for GTK
  programs.firefox.enable = true; #---------------# web browser
  programs.foot.enable = true; #------------------# terminal
  programs.git.enable = true; #-------------------# version control systemd-boot
  programs.gpu-screen-recorder.enable = true; #---# self expl.
  programs.hyprland.enable = true; #--------------# tiling wayland compositor
  programs.hyprland.xwayland.enable = true;
  programs.neovim = { #---------------------------# vim fork
    enable = true;
    defaultEditor = true;
  };
#  programs.obs-studio = { #-----------------------# open brodcasting software
#    enable = true;
#    # nvidia hardware acceleration
#    package = ( 
#      pkgs.obs-studio.override {
#        cudaSupport = true;
#      }
#    );
#    # plugins
#    plugins = with pkgs.obs-studio-plugins; [
#      wlrobs
#      obs-backgroundremoval
#      obs-pipewire-audio-capture
#      obs-gstreamer
#      obs-vkcapture
#    ];
#  };
  programs.steam = { #----------------------------# game distribution platform
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
  };
  programs.gamemode.enable = true;
  programs.waybar.enable = true; #----------------# status bar

  # run unpatched dynamic binaries (immutable file system problems ts)
  programs.nix-ld.enable = true;

  # enable gsettings backend (commented out for now - this was for kando)
  # programs.dconf.enable = true;

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
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";
    XDG_CACHE_HOME  = "$HOME/.cache";
  };

}


#     ██████╗  █████╗ ███████╗███████╗     ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ 
#     ██╔══██╗██╔══██╗██╔════╝██╔════╝    ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ 
#     ██████╔╝███████║███████╗█████╗      ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
#     ██╔══██╗██╔══██║╚════██║██╔══╝      ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
#     ██████╔╝██║  ██║███████║███████╗    ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
#     ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝     ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ 

{ config, pkgs, ... }:

# nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

# ░█▀▄░█▀█░█▀█░▀█▀░░░░
# ░█▀▄░█░█░█░█░░█░░░▀░
# ░▀▀░░▀▀▀░▀▀▀░░▀░░░▀░

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 2;
# boot.loader.timeout = lib.mkForce 1; # in case the above line doesn't work (add lib to modules!)
# boot.kernelParams = [ "random.trust_cpu=on" ];

  # ensure latest linux kernel is installed (disable for nvidia drivers)
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "CHANGEME";
  networking.networkmanager.enable = true;
# networking.wireless.enable = true;  # alt wireless support via wpa_supplicant

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

  hardware.bluetooth.enable = true; # enables support for bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default bluetooth controller on boot

# ░█░█░█▀▀░█▀▀░█▀▄░░░░
# ░█░█░▀▀█░█▀▀░█▀▄░░▀░
# ░▀▀▀░▀▀▀░▀▀▀░▀░▀░░▀░

  # define user account
  users.users = {
    changeme = {
     initialPassword = "temp";
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" "audio" "video"]; # sudo, the rest are self expl.
     packages = with pkgs; [];
   };
  };

  # set the time zone
  # time.timeZone = "Country/State"

# ░█▀▀░█▀█░█▀█░▀█▀░█▀▀░░░░
# ░█▀▀░█░█░█░█░░█░░▀▀█░░▀░
# ░▀░░░▀▀▀░▀░▀░░▀░░▀▀▀░░▀░

  fonts.packages = with pkgs; [
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
  ];


# ░█▀▀░█▀▀░█▀▄░█░█░▀█▀░█▀▀░█▀▀░█▀▀░░░░
# ░▀▀█░█▀▀░█▀▄░▀▄▀░░█░░█░░░█▀▀░▀▀█░░▀░
# ░▀▀▀░▀▀▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░░▀░

  # set maximum systemd log file size
  services.journald.extraConfig = "SystemMaxUse=50M";

  # disable wait for connection to boot
  # systemd.services.NetworkManager-wait-online.enable = false;

  # enable storage services
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # enable CUPS to print documents
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # enable the OpenSSH daemon
  # services.openssh.enable = true;

  # dont forget to enable nvidia or amd drivers!

# ░█▀▀░▀█▀░█▀▄░█▀▀░█░█░█▀█░█░░░█░░░░░░
# ░█▀▀░░█░░█▀▄░█▀▀░█▄█░█▀█░█░░░█░░░░▀░
# ░▀░░░▀▀▀░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀▀▀░░▀░

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
    allowedUDPPorts = [];
  };  


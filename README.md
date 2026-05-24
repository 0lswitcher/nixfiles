<p align="center">
  <img src="https://raw.githubusercontent.com/0lswitcher/dotfiles/refs/heads/main/md-assets/nixos/nixos.png" style="width: 25%; height: 25%">
</p>

[![Typing SVG](https://readme-typing-svg.demolab.com?font=Fira+Code&size=80&duration=2500&pause=1000&color=B277F7&center=true&vCenter=true&width=1920&height=100&lines=0lswitcher's+NixOS+Configuration+Files)](https://git.io/typing-svg)

<h1></h1>

<!--
<h1 align="center">
  NixOS configuration files
</h1>
-->

### Yo, welcome to my NixOS configuration files.  
Below I've included details for the structure of this directory so you can have a better idea of what you're looking at. 

> [!TIP]
> This repository has recently been overhauled for the new `nix-bootstrap.sh`! \
> Read below to learn more about the new script, and make sure to leave some feedback after trying it out! Thanks y'all o7

Each hostname is a seperate machine within my homelab using NixOS as its operating system;

<details>
  <summary>Smith</summary>
  This directory includes the configuration.nix file for Smith, a headless laptop (a.k.a "halftop") that is currently being utilized as a server.<br>  
  This configuration file is more focused on network security and stability rather than cool packages.
</details>

<details>
  <summary>Oracle</summary>
  This directory includes the configuration.nix file for Oracle, a hand-built desktop that serves as my workhorse pc.<br>
  This is my daily machine that I use for browsing, dev, and gaming so the majority of the "fun" packages are held here.<br> 
  Also serves as a secondary server for the more resource intensive services like machine learning, mc-servers, and LLM's.<br>
  ~ Configured for Nvidia GPU's - uncomment line 33, and comment lines 61-71 to remove said config
</details>


<details>
  <summary>Neo</summary>
  ~~This directory includes the configuration.nix file for Neo, a laptop that serves as my on-the-go workstation.~~<br>
  ~~Configured more for laptop use, and works great in tandem with my wayland/hyprland waybar config for Neo that contains laptop-specific things like a battery life indicator.~~<br>
  This directory is under construction until further notice, check out the [README](hostnames/neo/README.md) for more information!
</details>


Each role is an available option when running `nix-bootstrap.sh`;

<details>
  <summary>Server</summary>
  Server is the slimmest possible <code>.nix</code>, designed to be ran as a headless server.<br>
  Contains minimal packages like git and text editors.<br>
  Preconfigured SSH, fail2ban, and rootless docker.
</details>

<details>
  <summary>Minimal</summary>
  Minimal is a slimmer <code>.nix</code> that serves as a good starting point.<br>
  It still contains a fully fledged hyprland desktop, it's just designed to be a launch point for your own pkgs.
</details>

<details>
  <summary>Full</summary>
  Full is a larger <code>.nix</code> that serves as a good "daily-driver" ready machine.<br>
  (Currently configured for NixOS 25.11 - Xantusia)
</details>


Speaking of `nix-bootstrap.sh`, let's discuss the script and it's purpose since it's integral to the way I *(and hopefully you)* will initialize a NixOS machine...


# Nix(OS) Bootstrap

```
       ▓▓▓    ▒▒▒  ▒▒▒      
        ▓▓▓    ▒▒▒▒▒▒       
     ▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒          ██████   █████  ███  
    ▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒  ▓▓▓    ░░██████ ░░███  ░░░  
        ▒▒▒       ▒▒▒▓▓▓      ░███░███ ░███  ████  █████ █████    
  ▒▒▒▒▒▒▒▒         ▒▓▓▓▓▓▓▓   ░███░░███░███ ░░███ ░░███ ░░███  
  ▒▒▒▒▒▒▒▓         ▓▓▓▓▓▓▓▓   ░███ ░░██████  ░███  ░░░█████░    
     ▒▒▒▓▓▓       ▓▓▓         ░███  ░░█████  ░███   ███░░░███    
    ▒▒▒  ▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒     █████  ░░█████ █████ █████ █████  
         ▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒     ░░░░░    ░░░░░ ░░░░░ ░░░░░ ░░░░░   
        ▓▓▓▓▓▓    ▒▒▒       
       ▓▓▓  ▓▓▓    ▒▒▒      
                                                                                                                    
                                                                                         
  ███████████                     █████             █████                                 
 ░░███░░░░░███                   ░░███             ░░███                                  
  ░███    ░███  ██████   ██████  ███████    █████  ███████   ████████   ██████   ████████ 
  ░██████████  ███░░███ ███░░███░░░███░    ███░░  ░░░███░   ░░███░░███ ░░░░░███ ░░███░░███
  ░███░░░░░███░███ ░███░███ ░███  ░███    ░░█████   ░███     ░███ ░░░   ███████  ░███ ░███
  ░███    ░███░███ ░███░███ ░███  ░███ ███ ░░░░███  ░███ ███ ░███      ███░░███  ░███ ░███
  ███████████ ░░██████ ░░██████   ░░█████  ██████   ░░█████  █████    ░░████████ ░███████ 
 ░░░░░░░░░░░   ░░░░░░   ░░░░░░     ░░░░░  ░░░░░░     ░░░░░  ░░░░░      ░░░░░░░░  ░███░░░  
                                                                                ░███     
                                                                                █████    
                                                                               ░░░░░     
```


A complete NixOS system bootstrap designed to be ran post .iso installation and drive formatting. \
Allows for online or even offline installation the if repo files are held on usb or already on your system. \
<br>
Currently has 3 configuration profiles:
> `Server`, `Minimal`, and `Full`. \
> (Ranked in order of smallest to largest final size) 

And 2 hardware profiles:
>`Desktop`, `Laptop` \
> (Does not effect `hardware-configuration.nix`, only additional dotfiles.)

Which configures the following:
> - username
> - hostname
> - `configuration.nix`
>   - `environment.systemPackages`
>   - `environment.sessionVariables`
>   - `programs`
>   - `services`
>   - `system.stateVersion`
> - dotfiles
>   - hyprland
>   - waybar
>   - theming
>   - lots n lots more
> - `$HOME` directory 
> - wallpapers *(optional)*

To install and use the script from a fresh NixOS install, connect to the internet and run:
```
$ curl -sLO https://raw.githubusercontent.com/0lswitcher/bash-scripts/refs/heads/main/scripts/nix-bootstrap.sh
```

Then, make the script executable:
```
$ chmod +x ./nix-bootstrap.sh
```

Finally, run it!
```
$ bash ./nix-bootstrap.sh
```

---

:rage3: I LOVE NIXOS!! :rage3:

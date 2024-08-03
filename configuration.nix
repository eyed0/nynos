# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #inputs.home-manager.nixosModules.home-manager
      ./stylix.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.kernelModules = ["amdgpu"];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #home-manager.backupFileExtension = "backup";

  #  boot.loader = {
  #  grub = {
  #    enable = true;
  #    # version = 2;
  #    device = "nodev";
  #    useOSProber = true;
  #    efiSupport = true;
  #    timeoutStyle = "menu";
  #    fontSize = 24;
  #    enableCryptodisk = true;
  #  };
  #  efi = {
  #    canTouchEfiVariables = true;
  #    efiSysMountPoint = "/boot";
  #  };
  #};

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  #services.xserver = {
  #  layout = "us";
  #  xkbVariant = "";
  #};

  # Enable CUPS to print documents.
  #services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.heehaw = {
    isNormalUser = true;
    description = "heehaw";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Emacs
  services.emacs = {
    install = true;
    enable = true;
    package = pkgs.emacs29-pgtk;
    startWithGraphical = true;
    defaultEditor = true;
  };

  # git
  programs.git.enable = true;

  # KDE connect
  programs.kdeconnect.enable = true;

  # firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Activate and set fish shell as default
  programs.fish.enable = true;
  users.extraUsers.heehaw = {
    shell = "/run/current-system/sw/bin/fish";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {

      shells = [
        "${pkgs.fish}/bin/fish"
        "${pkgs.bash}/bin/bash"
      ];
      variables = {
        BROWSER = pkgs.lib.mkOverride 0 "firefox";
        EDITOR = pkgs.lib.mkOverride 0 "emacs";
      };
      systemPackages = with pkgs; [
        #       $ nix-env -qaP | grep wget to find packages

        #       dev

          #tree
          nh
          gcc
          lldb
          #bat
          ripgrep
          fd
          lsd # replacement for ls
          broot
          helix
          #      emacs29-pgtk
          (aspellWithDicts (dicts: with dicts; [ en en-computers en-science mr])) #emacs spellcheck for
          rustup
          #      sublme3
          #      gex # cli Git Explorer
          #jetbrains.idea-community
          #android-studio
          #jetbrains.jdk

        #       email

          #aerc
          thunderbird

        #       apps

          #vlc
          mpv
          fooyin
          nicotine-plus
          #appimage-run
          #inkscape
          #signal-desktop #signal messanger
          #gimp-with-plugins
          arduino # electronics prototyping platform
          #kanata # A tool to improve keyboard comfort and usability with advanced customization

        #       utilities

          dust # disk usage
          gcompris # educational software for children
          zoxide # A fast cd command that learns your habits
          navi # An interactive cheatsheet tool for the command-line and application launchers
          btop # graphical process/system monitor with a customizable interface
          gitui # Blazing fast terminal-ui for Git written in Rust
          starship # customizable prompt for any shell
          kitty
          restic # A backup program that is fast, efficient and secure
          rsync # Fast incremental file transfer utility
          qbittorrent
          nvtopPackages.full # top for gpu
          typst # latex alternative
          yazi # terminal file manager
          spotify-player # terminal spotify-player
          #digikam5
          #kate
          okular
          arianna # epub reader
          ark
          #peazip
          unrar
          rar
          xarchiver
          syncthing
          syncthingtray
          ffmpeg
          enchant #Generic spell checking library
          #libreoffice
          #freetube # youtube client
          #paperwork
          #pandoc # Conversion between documentation formats

        #       System

          cmake
          parted
          gparted
          #pciutils
          fastfetch

        #     # gaming
          lutris
          ryujinx
          # steam-run
          protonup
          protonup-qt
          wineWowPackages.staging
          # winetricks
          # protontricks
          scanmem

        #       hyprland
        #dunst
        #avizo
        #swappy
        #wl-screenrec
        #wl-clipboard
        #wl-clip-persist
        #cliphist
        #xdg-utils
        #wtype
        #wlrctl
        #grim
        #slurp
         #hyprshot
         eww
         #hyprcursor
        #rofi-wayland
         #anyrun
         #hyprshade
         #udiskie
         #wl-clipboard
         #swww
        #fuzzel
         #mako
         #swaynotificationcenter
         #gammastep
         #redshift
        #wlogout
         #blueman
         #brightnessctl
         #wlsunset
         #xss-lock
        #fcitx5
         #pavucontrol
      ];
    };


 # #   #    hyprland
 #  programs = {
 #   hyprland = {
 #      enable = true;
 #      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
 #      xwayland.enable = true;
 #      systemd.setPath.enable = true;
 #      portalPackage = pkgs.xdg-desktop-portal-hyprland;
 #    };
 #    hyprlock.enable = true;
 #    waybar.enable = true;
 #  };

 #  services.hypridle.enable = true;
 #  programs.nm-applet.enable = true;
 #  programs.nm-applet.indicator = true;
 #  #   XDG portal
 #  xdg.portal.enable = true;
 #  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
 #  xdg.icons.enable = true;
 #  programs.thunar.enable = true;

  #      Fonts

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "VictorMono" "SpaceMono" ]; })
    lexend
    lohit-fonts.marathi
    marathi-cursive
    aspellDicts.mr
    merriweather-sans
    atkinson-hyperlegible
    alegreya
    alegreya-sans
  ];

  programs.gamemode.enable = true;
  # programs.steam.enable = true;
  programs.gamescope.enable = true;
  # programs.steam.gamescopeSession.enable = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      amdvlk
      vulkan-tools
      #vulkan-utility-libraries
      #vulkan-volk
      vulkan-validation-layers
      vulkan-extension-layer
      #vkd3d-proton
    ];
  };

  #     garbage collection
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };
  };

  # experimental features flakes enable
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   #services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}

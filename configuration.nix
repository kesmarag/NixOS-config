{ config, pkgs, lib, ... }:


{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  nix = {
      extraOptions = "experimental-features = nix-command flakes";
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;
  boot.kernelParams = ["intel_pstate=active" "i915.enable_fbc=1" "i915.enable_psr=1" "quiet" "splash"];
  boot.blacklistedKernelModules = [ "psmouse" ];
  
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };
  zramSwap.enable = true;
  zramSwap.algorithm = "zstd";
  zramSwap.memoryPercent = 25;
  
  hardware.bluetooth.enable = true;
  
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      mesa
    ];
  };

  networking.networkmanager.plugins = with pkgs; [
    networkmanager-openvpn
  ];
  networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];

  
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  networking.hostName = "RungeKutta";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Athens";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  programs.kdeconnect.enable = true;

  
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    glibc
    zlib
    icu
    openssl
    curl
    expat
    libGL
    fontconfig
    freetype
    alsa-lib
  ];


  
  services.flatpak.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    discover];

  
  environment.systemPackages = with pkgs; [
  wget git tree rsync tmux
  vlc zoom-us
  fontconfig freetype
  home-manager
  alacritty
  obs-studio
  kdePackages.kfind
  kdePackages.kruler
  kdePackages.filelight
  kdePackages.kcalc
  kdePackages.sweeper
  kdePackages.kweather
  kdePackages.skanlite
  kdePackages.ktorrent
  kdePackages.kcolorpicker
  kdePackages.kio-fuse
  kdePackages.sddm-kcm
  kdePackages.kclock
  kdePackages.marble
  kdiff3
  direnv
  nix-direnv
  inkscape
  tmux
  notmuch
  isync
  xournalpp
  fastfetch
  figlet
  gparted
  chromium
  ipe
  pympress
  libvterm
  eduvpn-client
  spotify
  eza
  # qmk
  killall
  wayland-utils
  wl-clipboard
  lshw pciutils usbutils
  lm_sensors
  intel-gpu-tools
  gimp
  krita
  libreoffice-qt6
  mdbook
  brave
  # paraview
  # gmsh
  opencascade-occt
  nix-prefetch-git
  distrobox
];
  # # 2. Configure Bash system-wide to use direnv
  # programs.bash.bashrcExtra = ''
  #   if [ -x "$(command -v direnv)" ]; then
  #     eval "$(direnv hook bash)"
  #   fi
  # '';
  
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      liberation_ttf
      inter
      ibm-plex
      roboto
      dejavu_fonts
      cm_unicode
      iosevka
      jetbrains-mono
    ];
    fontconfig.enable = true;
    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif" "Noto Color Emoji"];
        sansSerif = ["Noto Sans" "Noto Color Emoji" ];
        monospace = [ "Iosevka" "Noto Color Emoji"];
      };
      antialias = true;
      hinting.enable = true;
      hinting.style = "slight";
    };
  };
  
  environment.variables.DIRENV_LOG_FORMAT = "";
  
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplipWithPlugin ];
  
  services.keyd.enable = true;
  environment.etc."keyd/default.conf".source = ./conf/keyd.conf; 

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };


  users.users.kesmarag = {
    isNormalUser = true;
    description = "Costas Smaragdakis";
    home = "/home/kesmarag";
    extraGroups = [ "networkmanager" "wheel" ];
  };


  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = true;

  environment.sessionVariables = {
    EDITOR = "nano";
    BROWSER = "firefox";
    LIBVA_DRIVER_NAME = "iHD";
  };


  virtualisation.podman.enable = true;
  virtualisation.podman.dockerSocket.enable = true;
  
  environment.sessionVariables = {
    GTK_USE_PORTAL = "1";
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];
  };

  system.stateVersion = "25.05"; 

}

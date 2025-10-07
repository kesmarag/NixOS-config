{ config, pkgs, lib, ... }:


{
  imports =
    [ # Include the results of the hardware scan.
      # <home-manager/nixos>
      ./hardware-configuration.nix
    ];

  nix = {
      extraOptions = "experimental-features = nix-command flakes";
  };


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;
  boot.kernelParams = ["intel_pstate=active" "i915.enable_fbc=1" "i915.enable_psr=1" "v4l2loopback" "quiet" "splash"];
  boot.blacklistedKernelModules = [ "psmouse" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=10 card_label="OBS Virtual Camera" exclusive_caps=1
  '';
  
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };
  zramSwap.enable = true;
  zramSwap.algorithm = "zstd";
  zramSwap.memoryPercent = 25;
  
  # services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
    ];
  };

  networking.networkmanager.plugins = with pkgs; [
    networkmanager-openvpn
  ];

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

  # KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  programs.kdeconnect.enable = true;

  
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Core system libraries
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
  # GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  # services.displayManager.gdm.enable = true;
  # services.desktopManager.gnome.enable = true;
  # services.gnome.core-apps.enable = false;
  # services.gnome.core-developer-tools.enable = false;
  # services.gnome.games.enable = false;
  # environment.gnome.excludePackages = with pkgs; [
  # gnome-tour
  # gnome-user-docs];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    discover];

  
  environment.systemPackages = with pkgs; [
  # core utilities
  wget git tree rsync tmux
  # programs
  vlc zoom-us
  # fonts
  fontconfig freetype
  home-manager
  # nautilus loupe papers gnome-console gnome-weather gnome-maps # gnome
  # gnome-tweaks
  alacritty
  # adw-gtk3
  # texliveMedium
  dconf-editor
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
  guvcview
  direnv
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
  pdfpc
  pympress
  libvterm
  eduvpn-client
  spotify
  gemini-cli
  #copyq
  eza
  # Install direnv so the shell hook can find it
  direnv
  # qmk
  killall
  wl-clipboard
  lshw pciutils usbutils
  lm_sensors
  intel-gpu-tools
  gimp
  # krita
  libreoffice-qt6
  mdbook
  # bleachbit

  # Build Emacs with your required packages
#  ((pkgs.emacsPackagesFor pkgs.emacs-pgtk).emacsWithPackages (epkgs: with epkgs; [
#    straight
#    magit
#    lsp-mode
#    lsp-ui
#    pdf-tools
#    vterm
#    notmuch
#    direnv
#    nix-mode
#    rust-mode
#    ]))
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
      noto-fonts-emoji
      liberation_ttf
      inter
      ibm-plex
      roboto
      dejavu_fonts
      # aporetic
      cm_unicode
      iosevka
      jetbrains-mono
    ];
    fontconfig.enable = true;
    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = ["Roboto" "Noto Sans" ];
        monospace = [ "Iosevka" ];
      };
      antialias = true;
      hinting.enable = true;
      hinting.style = "slight";
    };
    fontconfig.localConf = ''
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
      <fontconfig>
        <!-- Prefer emoji fonts when emoji codepoints are used -->
        <alias>
          <family>sans-serif</family>
          <prefer>
            <family>Noto Color Emoji</family>
          </prefer>
        </alias>

        <alias>
          <family>serif</family>
          <prefer>
            <family>Noto Color Emoji</family>
          </prefer>
        </alias>

        <alias>
          <family>monospace</family>
          <prefer>
            <family>Noto Color Emoji</family>
          </prefer>
        </alias>
      </fontconfig>
    '';
  };
  

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

  # programs.kdeconnect.enable = true;

  environment.sessionVariables = {
    # Development
    EDITOR = "nano";
    BROWSER = "firefox";
    # Intel graphics
    LIBVA_DRIVER_NAME = "iHD";
  };


  
  environment.sessionVariables = {
    GTK_USE_PORTAL = "1";
  };

  # environment.variables = {
  #   QT_QPA_PLATFORMTHEME = "gnome";
  # };

  xdg.portal = {
    enable = true;
    # If you are on Wayland, this is also a good idea.
    wlr.enable = true;
    
    # This is the key line. It adds the KDE backend for the portal.
    extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];
  };

  
  
  system.stateVersion = "25.05"; 

}

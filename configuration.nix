{ config, pkgs, lib, ... }:


{
  imports =
    [ # Include the results of the hardware scan.
      <home-manager/nixos>
      ./hardware-configuration.nix
    ];

  nix = {
      extraOptions = "experimental-features = nix-command flakes";
  };


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;
  boot.kernelParams = ["intel_pstate=active" "i915.enable_fbc=1" "i915.enable_psr=1" "quiet" "splash"];

  # services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
    ];
  };

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

  services.printing.enable = true;

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


  home-manager.useGlobalPkgs = true;
  home-manager.users.kesmarag = {
    imports = [ ./home.nix ];
  };

  nixpkgs.config.allowUnfree = true;


  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
  # core utilities
  wget git tree rsync curl tmux
  # programs
  vlc zoom-us
  # fonts
  inter fontconfig freetype
  home-manager
  ];


  environment.sessionVariables = {
    # Development
    EDITOR = "nano";
    BROWSER = "firefox";
    # Intel graphics
    LIBVA_DRIVER_NAME = "iHD";
  };


  # Enable XDG portals
  xdg.portal = {
    enable = true;
    # If you are on Wayland, this is also a good idea.
    wlr.enable = true;
    
    # This is the key line. It adds the KDE backend for the portal.
    extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];
  };

fonts = {
  enableDefaultPackages = true;
  fontconfig = {
    enable = true;
    antialias = true;
    subpixel = {
      rgba = "rgb"; 
    };
    hinting = {
      enable = true;
      style = "slight"; 
    };
  };
};



  system.stateVersion = "25.05"; 

}

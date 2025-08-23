# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

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

  # 3. Enable non-free firmware, which is needed for many devices
  hardware.enableRedistributableFirmware = true;

  # 4. Enable Intel CPU microcode updates
  # This line automatically enables microcode updates if you enable the firmware above.
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;



  networking.hostName = "RungeKutta"; 
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Athens";

  # Select internationalisation properties.
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



  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;


  services.keyd.enable = true;

  environment.etc."keyd/default.conf".source = ./conf/keyd.conf; 


  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kesmarag = {
    isNormalUser = true;
    description = "Costas Smaragdakis";
    home = "/home/kesmarag";
    extraGroups = [ "networkmanager" "wheel" ];
    #packages = with pkgs; [
    #  kdePackages.kate
    #  thunderbird
    #];
  };

# home-manager.users.kesmarag = import ./home.nix;
 home-manager.useGlobalPkgs = true;
 home-manager.users.kesmarag = {
    imports = [ ./home.nix ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # Install firefox.
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
      rgba = "rgb"; # or "bgr" depending on your panel
    };
    hinting = {
      enable = true;
      style = "slight"; # options: none, slight, medium, full
    };
  };
};



  system.stateVersion = "25.05"; # Did you read the comment?

}

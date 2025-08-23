# /etc/nixos/home.nix

{ config, pkgs, ... }:

{
  # home.username = "kesmarag";
  # home.homeDirectory = "/home/kesmarag";

  # nixpkgs.config.allowUnfree = true;

  # Add packages that should be installed for your user.
  home.packages = [
    pkgs.corefonts
    pkgs.texliveFull
	pkgs.aporetic
    pkgs.obs-studio
    pkgs.kdePackages.kfind
    pkgs.kdePackages.kruler
    pkgs.direnv
    pkgs.inkscape
    pkgs.spotify
    pkgs.tmux
    pkgs.notmuch
    pkgs.isync
    pkgs.xournalpp
    pkgs.fastfetch
    pkgs.figlet
    pkgs.redhat-official-fonts
    pkgs.gparted
    pkgs.chromium
  ];

  # An example of managing a dotfile
  home.file.".my-cool-alias" = {
    text = ''
      alias ll='ls -alF'
      alias ..='cd ..'
    '';
  };

  # Set some environment variables
  home.sessionVariables = {
    EDITOR = "nano";
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  home.stateVersion = "25.05";

  # programs.home-manager.enable = true;

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs: [
      epkgs.doric-themes
      epkgs.vertico
      epkgs.orderless
      epkgs.corfu
      epkgs.kind-icon
      epkgs.cape
      epkgs.which-key
      epkgs.undo-tree
      epkgs.comment-dwim-2
      epkgs.olivetti
      epkgs.yasnippet
      epkgs.marginalia
      epkgs.magit
      epkgs.lsp-mode
      epkgs.lsp-ui
      #(epkgs.auctex.override { with-reftex = true; }) # Ensure auctex has reftex
      epkgs.pdf-tools
      epkgs.vterm
      epkgs.notmuch
      epkgs.markdown-mode
      epkgs.direnv
    ];
    extraConfig = builtins.readFile ./conf/emacs.el;
  };

  # Configure your shell to use direnv hooks
  programs.bash.enable = true;
  programs.bash.initExtra = "eval \"$(direnv hook bash)\"";

}

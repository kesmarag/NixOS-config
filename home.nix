# /etc/nixos/home.nix

{ config, pkgs, ... }:

{

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

  home.file.".kesmarag-alias" = {
    text = ''
      alias ll='ls -alF'
      alias ..='cd ..'
    '';
  };

  # Set some environment variables
  home.sessionVariables = {
    EDITOR = "nano";
  };

  home.stateVersion = "25.05";

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

  # Configure the shell to use direnv hooks
  programs.bash.enable = true;
  programs.bash.initExtra = "eval \"$(direnv hook bash)\"";

}

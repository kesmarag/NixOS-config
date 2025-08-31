# /etc/nixos/home.nix

{ config, pkgs, ... }:

{

  home.packages = [ ];

  home.file.".kesmarag-alias" = {
    text = ''
      alias ll='ls -alF'
      alias ..='cd ..'
    '';
  };

  # Set some environment variables
  home.sessionVariables = {
    EDITOR = "emacs -nw";
  };

  home.stateVersion = "25.05";

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs: [
      epkgs.straight
      epkgs.magit
      epkgs.lsp-mode
      epkgs.lsp-ui
      # (epkgs.auctex.override { with-reftex = true; }) # Ensure auctex has reftex
      epkgs.pdf-tools
      epkgs.vterm
      epkgs.notmuch
      epkgs.direnv
      epkgs.nix-mode
    ];
    # extraConfig = builtins.readFile ./conf/emacs.el;
  };

  # Configure the shell to use direnv hooks
  programs.bash.enable = true;
  programs.bash.initExtra = "eval \"$(direnv hook bash)\"";

}

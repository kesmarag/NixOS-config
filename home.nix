# /etc/nixos/home.nix

{ config, pkgs, ... }:

{

  home.username = "kesmarag";
  home.homeDirectory = "/home/kesmarag";

  home.packages = [ ];

  home.file.".kesmarag-alias" = {
    text = ''
      alias ll='ls -alF'
      alias ..='cd ..'
    '';
  };

  home.sessionVariables = {
    EDITOR = "emacs -nw";
  };


  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs: with epkgs; [
      straight
      magit
      lsp-mode
      lsp-ui
      pdf-tools
      vterm
      notmuch
      direnv
      nix-mode
      rust-mode
    ];
  };


  services.emacs.enable = true;
  
  home.stateVersion = "25.05";

}

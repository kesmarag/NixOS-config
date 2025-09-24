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

  # services.emacs = {
  #   enable = true;
  #   package = pkgs.emacs-pgtk; 
  # };
  
  home.stateVersion = "25.05";

}

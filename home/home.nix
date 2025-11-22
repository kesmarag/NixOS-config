# /etc/nixos/home.nix

{ config, pkgs, ... }:

{

  home.username = "kesmarag";
  home.homeDirectory = "/home/kesmarag";

  home.packages = [];

  home.file.".kesmarag-alias" = {
    text = ''
      alias ll='ls -alF'
      alias ..='cd ..'
    '';
  };

  
  home.stateVersion = "25.05";

}

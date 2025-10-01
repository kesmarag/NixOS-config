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
    # 1. Specify the base Emacs package
    package = pkgs.emacs-pgtk;

    # 2. List all the packages you want Nix to manage
    extraPackages = epkgs: with epkgs; [
      # Your list of packages goes here
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
      # Add exec-path-from-shell, as we discussed
      # exec-path-from-shell
    ];
  };


  services.emacs.enable = true;

  # services.kio-fuse.enable = true;
  
  # services.emacs = {
  #   enable = true;
  #   package = pkgs.emacs-pgtk; 
  # };
  
  home.stateVersion = "25.05";

}

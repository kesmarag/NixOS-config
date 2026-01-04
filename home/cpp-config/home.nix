{ config, pkgs, ... }:
{
  home.packages = [];


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

}

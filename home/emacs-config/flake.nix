{
  description = "emacs home-manager configuration";

  inputs = {
    # 1. We define the source we want to update independently
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  # 2. CHANGED: We added 'nixpkgs' here so the function accepts the input
  outputs = { self, nixpkgs }: {

    # 3. CHANGED: We convert homeModule into a function that configures the system
    homeModule = { config, pkgs, ... }:
    let
      # 4. We create a custom version of pkgs using the input from THIS file (not the root system)
      pinnedPkgs = import nixpkgs {
        system = pkgs.system;
        config.allowUnfree = true;
      };
    in
    {
      imports = [ ./home.nix ];

      # 5. We force programs.emacs to use OUR pinned version of emacs-pgtk.
      #    We use 'mkForce' to override the "pkgs.emacs-pgtk" setting inside your home.nix
      programs.emacs.package = pkgs.lib.mkForce pinnedPkgs.emacs-pgtk;
    };
  };
}

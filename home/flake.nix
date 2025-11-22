# ~/dotfiles/flake.nix
{
  description = "kesmarag's Home Manager Flake";

  inputs = {
    # Nix Packages collection
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    juliaConfig = {
      url = "path:./julia-config";
      flake = true;
    };

    pythonConfig = {
      url = "path:./python-config";
      flake = true;
    };

    emacsConfig = {
      url = "path:./emacs-config";
      flake = true;
    };

    latexConfig = {
      url = "path:./latex-config";
      flake = true;
    };

  };


  outputs = { self, nixpkgs, home-manager, juliaConfig, pythonConfig, emacsConfig, latexConfig, ... }: {

    homeConfigurations = {
      "kesmarag" = home-manager.lib.homeManagerConfiguration {

        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [ ./home.nix
                    juliaConfig.homeModule
                    pythonConfig.homeModule
                    emacsConfig.homeModule
                    latexConfig.homeModule
                  ];

      };
    };
  };
}

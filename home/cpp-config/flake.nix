{
  description = "Clang/C++ Home Manager Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {

    homeModule = { config, pkgs, ... }:
    let
      pinnedPkgs = import nixpkgs {
        system = pkgs.system;
        config.allowUnfree = true;
      };
      llvm = pinnedPkgs.llvmPackages;
    in
    {
      imports = [ ./home.nix ];

      home.packages = [
        llvm.clang
        llvm.openmp
        pinnedPkgs.cmake
        pinnedPkgs.ninja
        pinnedPkgs.clang-tools
        pinnedPkgs.cppcheck
        pinnedPkgs.valgrind
      ];
    };
  };
}

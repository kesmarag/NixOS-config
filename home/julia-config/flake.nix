{
  description = "julia home-manager configuration";

  outputs = { self }: {
    homeModule = ./home.nix;
  };
}

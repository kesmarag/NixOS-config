{
  description = "python home-manager configuration";

  outputs = { self }: {
    homeModule = ./home.nix;
  };
}

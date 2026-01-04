{ config, pkgs, ... }:
{
  home.sessionVariables = {
    CC = "clang";
    CXX = "clang++";
    CMAKE_GENERATOR = "Ninja";
  };
}

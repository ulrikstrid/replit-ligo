{ pkgs }:

let
  pkgs = import ./nix/pkgs.nix;
in

{
  deps = [
    pkgs.cachix
    pkgs.ligo
  ];
}

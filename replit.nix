{ pkgs }:

let
  pkgs = import
    (builtins.fetchTarball {
      # Descriptive name to make the store path easier to identify
      name = "nixpkgs-ligo-dev";
      # Commit hash for nixos-unstable as of 2021-07-19
      url = "https://github.com/ulrikstrid/nixpkgs/archive/5c5d2283515c6d0d45092d4f689ae795c6009217.tar.gz";
      # Hash obtained using `nix-prefetch-url --unpack <url>`
      sha256 = "1iaxyw8zg8w8vhp3hxp159843d6sbvfi3a32564xkjkx3j27k5rf";
    })
    { };
in

{
  deps = [
    pkgs.cachix
    pkgs.ligo
  ];
}

{ pkgs }:

let
  pkgs = import
    (builtins.fetchTarball {
      # Descriptive name to make the store path easier to identify
      name = "nixpkgs-ligo-dev";
      # Commit hash for nixos-unstable as of 2021-07-19
      url = "https://github.com/ulrikstrid/nixpkgs/archive/dc2e1dbe79b317493b46ed9a641019fc14c539fd.tar.gz";
      # Hash obtained using `nix-prefetch-url --unpack <url>`
      sha256 = "045g6xsrf7sgs69z1g6qli1rbwilf58gaqycfv60fssj2mmrh3lc";
    })
    { };
in

{
  deps = [
    pkgs.cachix
    pkgs.ligo
  ];
}

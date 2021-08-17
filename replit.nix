{ pkgs }:

let
  pkgs = import
    (builtins.fetchTarball {
      # Descriptive name to make the store path easier to identify
      name = "nixpkgs-ligo-dev";
      # Commit hash for nixos-unstable as of 2021-07-19
      url = "https://github.com/ulrikstrid/nixpkgs/archive/aa7188fd80d4f6e2b043f16d3a29eb5f9bb3b540.tar.gz";
      # Hash obtained using `nix-prefetch-url --unpack <url>`
      sha256 = "0v55kskm72pqskvv8flz8kvqci4rzdw7dw5r1jahinxm5zpi92f4";
    })
    { };
in

{
  deps = [
    pkgs.cachix
    pkgs.ligo
  ];
}

import (builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  name = "nixpkgs-ligo-dev";
  # Commit hash for nixos-unstable as of 2021-07-19
  url = "https://github.com/ulrikstrid/nixpkgs/archive/bd9aa3a1d8f4be262fba983e534c268475899621.tar.gz";
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "0nc7xlyjpg1s3qijb01mwd1hjagbcy7lg06dpc4srh4cflkwsmvp";
}) {}

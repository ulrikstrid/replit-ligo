let
  pkgs = import
    (builtins.fetchTarball {
      # Descriptive name to make the store path easier to identify
      name = "nixpkgs-ligo-dev";
      # Commit hash for nixos-unstable as of 2021-07-19
      url = "https://github.com/ulrikstrid/nixpkgs/archive/4e20a7c4fd22d7ad814185117fb3ddd5d4708a9e.tar.gz";
      # Hash obtained using `nix-prefetch-url --unpack <url>`
      sha256 = "1aac5fp8jrkw23ncwyjppxh28pww83v6ahf9z16y686vl9jp99d9";
    })
    { };
in

pkgs.mkShell {
  nativeBuildInputs = [
    pkgs.ligo
  ];
}

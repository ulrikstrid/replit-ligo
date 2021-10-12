let
  pkgs = import
    (builtins.fetchTarball {
      # Descriptive name to make the store path easier to identify
      name = "nixpkgs-ligo-dev";
      # Commit hash for nixos-unstable as of 2021-07-19
      url = "https://github.com/ulrikstrid/nixpkgs/archive/cd0276d5333009b641f2e87ac332cbd0338eac2a.tar.gz";
      # Hash obtained using `nix-prefetch-url --unpack <url>`
      sha256 = "1z4djc5mb1qavvvnhj5w6kbbg3x34vpi81nqjpnvn2nn4crmml3f";
    })
    { };
in

pkgs.mkShell {
  nativeBuildInputs = [
    pkgs.ligo
  ];
}

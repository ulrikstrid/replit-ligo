let
  pkgs = import
    (builtins.fetchTarball {
      # Descriptive name to make the store path easier to identify
      name = "nixos-unstable-2021-07-19";
      # Commit hash for nixos-unstable as of 2021-07-19
      url = "https://github.com/nixos/nixpkgs/archive/b59c06dc92f8d03660eb4155754d93a6c34cda83.tar.gz";
      # Hash obtained using `nix-prefetch-url --unpack <url>`
      sha256 = "1mjvaasd1f2x0zly3vaj94dgjsqbqii9rdys12pzr2yz7qqrwsvk";
    })
    { };
  ocamlVersion = "4_10";
  tezosPkgs = pkgs.callPackage ./nix {
    ocamlPackages = (pkgs.ocaml-ng."ocamlPackages_${ocamlVersion}");
  };
in

pkgs.mkShell {
  nativeBuildInputs = [
    tezosPkgs.ligo
  ];
}

let
  pkgs = import ./nix/pkgs.nix;
in

pkgs.mkShell {
  nativeBuildInputs = [
    pkgs.ligo
  ];
}

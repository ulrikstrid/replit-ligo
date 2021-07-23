# ligo playground

This repo is a playground for ligo using nix as the build platform.

## Local

> To use this locally you must have [nix][https://nixos.org/] installed.

We have a `shell.nix` that is prepared for ligo development. To enter the nix-shell with `ligo` available simply run `nix-shell`.

You can also execute one-off commands like this:

```sh
nix-shell --run 'ligo <SUBCOMMAND> ...'
nix-shell --run 'ligo repl cameligo'
```

### cache

To speed up the build time you can add [cachix](https://cachix.org) cache https://ligolang.cachix.org, see [nix.conf](./.config/nix/nix.conf) for details.

The cache should work on Linux and macOS (currently not m2 based macs).

## replit

You can run this playground on replit, just click this button.

[![Run on Repl.it](https://repl.it/badge/github/ulrikstrid/replit-ligo)](https://repl.it/github/ulrikstrid/replit-ligo)

## notes

We are working on upstreaming ligo packages to nixpkgs but it's a long process.
That's why we have added a bunch of packages to [this file](./nix/default.nix), this file should shrink over time as more and more packages are added upstream.

The [contract](./consensus.mligo) is borrowed from [marigolds sidechain repo](https://github.com/marigold-dev/sidechains).

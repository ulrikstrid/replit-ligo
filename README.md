# LIGO playground

This repo is a playground for LIGO using nix as the build platform.

## repl.it

You can run this playground on [repl.it](https://repl.it/), just click this button.

[![Run on Repl.it](https://repl.it/badge/github/ulrikstrid/replit-ligo)](https://repl.it/github/ulrikstrid/replit-ligo)

## Local

> To use this locally you must have [nix](https://nixos.org/) installed.

We have a `shell.nix` that is prepared for LIGO development. To enter the nix-shell with `ligo` available simply run `nix-shell`.

You can also execute one-off commands like this:

```sh
nix-shell --run 'ligo <SUBCOMMAND> ...'
nix-shell --run 'ligo repl cameligo'
```

### cache

To speed up the build time you can add [cachix](https://cachix.org) cache https://ligolang.cachix.org, see [nix.conf](./.config/nix/nix.conf) for details.

## notes

It currently only works on Linux because of dependencies that doesn't build on macOS.

We are working on upstreaming LIGO packages to nixpkgs but it's a long process.
That's why we have added a bunch of packages to [this file](./nix/default.nix), this file should shrink over time as more and more packages are added upstream.

The [contract](./consensus.mligo) is borrowed from [marigolds sidechain repo](https://github.com/marigold-dev/sidechains).

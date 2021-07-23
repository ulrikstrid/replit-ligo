# ligo playground

This repo is a playground for ligo using nix as the build platform.

## replit

You can run this playground on replit, just click this button.

[![Run on Repl.it](https://repl.it/badge/github/ulrikstrid/replit-ligo)](https://repl.it/github/ulrikstrid/replit-ligo)

## notes

We are working on upstreaming ligo packages to nixpkgs but it's a long process.
That's why we have added a bunch of packages to [this file](./nix/default.nix), this file should shrink over time as more and more packages are added upstream.

The [contract](./consensus.mligo) is borrowed from [marigolds sidechain repo](https://github.com/marigold-dev/sidechains).

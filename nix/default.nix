{ pkgs ? import <nixpkgs> { }, stdenv, fetchzip, lib, ocamlPackages ? pkgs.ocaml-ng.ocamlPackages_4_10 }:

with ocamlPackages;
rec {
  getopt = buildDunePackage {
    pname = "getopt";
    version = "20210705-dev";

    src = builtins.fetchurl {
      url = https://github.com/ulrikstrid/ocaml-getopt/archive/645ab740c5a8d2ca1ec1099e4a05580009a913e9.tar.gz;
      sha256 = "1qpnfv5wrh7kzi996fsfw62vl62gh45h3y6b3v71ahbqbxd1akgg";
    };
    useDune2 = true;
  };

  ligo = buildDunePackage rec {
    pname = "ligo";

    inherit (ligo-simple-utils) version src useDune2;

    # https://gitlab.com/ligolang/ligo/-/merge_requests/1211
    patches = [ ./remove-problematic-deps.patch ];

    postPatch = ''
      find src -name '*.ml' -exec sed -i 's/Tezos_client_008_PtEdo2Zk/Client_utils_008_PtEdo2Zk/g' {} \;
      rm -rf vendors
    '';

    prehase = "dune build --release -p ligo @install --verbose";

    buildInputs = with ocamlPackages; [
      pkgs.coq
      menhir
      menhirLib
      qcheck
      ocamlgraph
      ppx_deriving
      ppx_deriving_yojson
      ppx_expect
      tezos-base
      tezos-shell-services
      tezos-protocol-008-PtEdo2Zk-parameters
      tezos-protocol-008-PtEdo2Zk
      tezos-protocol-environment
      yojson
      getopt
      terminal_size
      pprint
      linenoise
      data-encoding
      bisect_ppx
      cmdliner

      ligo-simple-utils
      ligo-tezos-utils
      ligo-client_utils-008-PtEdo2Zk
      ligo-LexerLib
      ligo-ParserLib
      ligo-Preprocessor
      ligo-proto-alpha-utils
      ligo-simple-utils
      ligo-tezos-utils
      ligo-UnionFind
      ligo-008-PtEdo2Zk-test-helpers
    ];

    checkInputs = [
      ligo-008-PtEdo2Zk-test-helpers
    ];

    doCheck = false;
  };

  ligo-client_utils-008-PtEdo2Zk = buildDunePackage rec {
    pname = "client_utils-008-PtEdo2Zk";
    inherit (ligo-simple-utils) version src useDune2;

    patches = [ ./remove-problematic-deps.patch ];

    preBuild = ''
      rm -rf src
      ls vendors | grep -v ligo-utils | xargs rm -rf
      ls vendors/ligo-utils | grep -v client_utils_008_PtEdo2Zk | xargs rm -rf
    '';

    propagatedBuildInputs = [
      tezos-base
      ligo-tezos-utils
      tezos-stdlib-unix
      tezos-shell-services
      tezos-protocol-environment
      tezos-protocol-008-PtEdo2Zk
      tezos-protocol-008-PtEdo2Zk-parameters
      ligo-tezos-memory-proto-alpha
    ];

    doCheck = false;
  };

  ligo-LexerLib = buildDunePackage rec {
    pname = "LexerLib";
    inherit (ligo-simple-utils) version src useDune2;

    patches = [ ./remove-problematic-deps.patch ];

    propagatedBuildInputs = [
      base
      ligo-simple-utils
      bisect_ppx
      getopt
      uutf
    ];

    doCheck = false;
  };

  ligo-008-PtEdo2Zk-test-helpers = buildDunePackage rec {
    pname = "ligo-008-PtEdo2Zk-test-helpers";
    inherit (ligo-simple-utils) version src useDune2;

    patches = [ ./remove-problematic-deps.patch ];

    propagatedBuildInputs = [
      tezos-base
      tezos-stdlib-unix
      tezos-shell-services
      tezos-protocol-environment
      tezos-protocol-008-PtEdo2Zk
      tezos-protocol-008-PtEdo2Zk-parameters
      ligo-client_utils-008-PtEdo2Zk
      alcotest-lwt
    ];

    doCheck = false;
  };

  ligo-ParserLib = buildDunePackage rec {
    pname = "ParserLib";
    inherit (ligo-simple-utils) version src useDune2 preBuild;

    propagatedBuildInputs = [
      base
      ligo-simple-utils
      bisect_ppx
      menhir
      menhirLib
      getopt
    ];

    doCheck = false;
  };

  ligo-Preprocessor = buildDunePackage rec {
    pname = "Preprocessor";
    inherit (ligo-simple-utils) version src useDune2 preBuild;

    propagatedBuildInputs = [
      base
      ligo-simple-utils
      bisect_ppx
      menhir
      getopt
    ];

    doCheck = false;
  };

  ligo-proto-alpha-utils = buildDunePackage rec {
    pname = "proto-alpha-utils";
    inherit (ligo-simple-utils) version src useDune2;

    patches = [ ./remove-problematic-deps.patch ];

    propagatedBuildInputs = [
      base
      bigstring
      calendar
      cohttp-lwt-unix
      cstruct
      ezjsonm
      hex
      ipaddr
      macaddr
      irmin
      js_of_ocaml
      lwt
      lwt_log
      mtime
      ocplib-endian
      ocp-ocamlres
      re
      rresult
      stdio
      uri
      uutf
      zarith
      ocplib-json-typed
      ocplib-json-typed-bson
      tezos-crypto
      tezos-error-monad
      tezos-stdlib-unix
      tezos-protocol-environment
      tezos-protocol-008-PtEdo2Zk
      tezos-protocol-008-PtEdo2Zk-parameters
      ligo-tezos-memory-proto-alpha
      ligo-client_utils-008-PtEdo2Zk
      ligo-simple-utils
      ligo-tezos-utils
    ];

    doCheck = false;
  };

  ligo-RedBlackTrees = buildDunePackage rec {
    pname = "RedBlackTrees";
    inherit (ligo-simple-utils) version src useDune2;

    preBuild = ''
      rm -rf src
      ls vendors | grep -v Red-Black_Trees | xargs rm -rf
    '';

    doCheck = false;
  };

  ligo-simple-utils = buildDunePackage rec {
    pname = "simple-utils";
    version = "0.20.0";

    src = builtins.fetchurl {
      url = "https://gitlab.com/ligolang/ligo/-/archive/${version}/ligo-${version}.tar.bz2";
      sha256 = "1cxn1hrhig3hk8iby6sp5901bicvwqs7f6x6y5q6cmm96pkvbanl";
    };

    # patches = [ ./remove-problematic-deps.patch ];

    preBuild = ''
      rm -rf src
      ls vendors | grep -v ligo-utils | grep -v ${pname} | xargs rm -rf
      ls vendors/ligo-utils | grep -v ${pname} |xargs rm -rf
      echo "prebuild done"
    '';

    useDune2 = true;

    propagatedBuildInputs = [
      base
      yojson
      ppx_deriving
      ppx_deriving_yojson
    ];

    doCheck = false;
  };

  ligo-tezos-memory-proto-alpha = buildDunePackage rec {
    pname = "tezos-memory-proto-alpha";
    inherit (ligo-simple-utils) version src useDune2 preBuild;

    propagatedBuildInputs = [
      tezos-protocol-environment
      tezos-protocol-008-PtEdo2Zk
    ];

    doCheck = false;
  };

  ligo-tezos-utils = buildDunePackage rec {
    pname = "tezos-utils";

    inherit (ligo-simple-utils) version src preBuild useDune2;

    propagatedBuildInputs = [
      base
      bigstring
      calendar
      cohttp-lwt-unix
      cstruct
      ezjsonm
      hex
      irmin
      js_of_ocaml
      lwt
      lwt_log
      mtime
      ocplib-endian
      ocp-ocamlres
      re
      rresult
      stdio
      uri
      uutf
      zarith
      ocplib-json-typed
      ocplib-json-typed-bson
      tezos-crypto
      tezos-stdlib-unix
      tezos-micheline
      tezos-base
      data-encoding
      ligo-simple-utils
    ];

    doCheck = false;
  };

  ligo-UnionFind = buildDunePackage rec {
    pname = "UnionFind";
    inherit (ligo-simple-utils) version src useDune2;

    preBuild = ''
      ${ligo-simple-utils.preBuild}
      printf 'let version = "%s"' "${version}" > version.ml
    '';

    propagatedBuildInputs = [
      ligo-RedBlackTrees
    ];

    doCheck = false;
  };

  tezos-base = buildDunePackage {
    pname = "tezos-base";
    inherit (tezos-stdlib) version src useDune2 preBuild;

    propagatedBuildInputs = [
      tezos-crypto
      tezos-micheline
      ptime
      ezjsonm
      ipaddr
    ];
  };

  tezos-clic = buildDunePackage {
    pname = "tezos-clic";
    inherit (tezos-stdlib) version src useDune2 preBuild;

    propagatedBuildInputs = [
      tezos-stdlib-unix
    ];

    meta = tezos-stdlib.meta // {
      description = "Tezos: library of auto-documented command-line-parsing combinators";
    };
  };

  tezos-crypto = buildDunePackage {
    pname = "tezos-crypto";
    inherit (tezos-stdlib) version src useDune2 preBuild;

    propagatedBuildInputs = with ocamlPackages; [
      tezos-clic
      tezos-rpc
      bls12-381
      hacl-star
      secp256k1-internal
      uecc
      ringo
    ];

    meta = tezos-stdlib.meta // {
      description = "Tezos: library with all the cryptographic primitives used by Tezos";
    };
  };

  tezos-shell-services = buildDunePackage {
    pname = "tezos-shell-services";
    inherit (tezos-stdlib) version src useDune2 preBuild;

    propagatedBuildInputs = [
      tezos-workers
      tezos-p2p-services
      tezos-version
    ];

    meta = tezos-stdlib.meta // {
      description = "Tezos: descriptions of RPCs exported by `tezos-shell`";
    };
  };

  tezos-error-monad = buildDunePackage {
    pname = "tezos-error-monad";
    inherit (tezos-stdlib) version src useDune2 preBuild;

    propagatedBuildInputs = with ocamlPackages; [
      tezos-stdlib
      data-encoding
      lwt
      lwt-canceler
    ];

    meta = tezos-stdlib.meta // {
      description = "Tezos: error monad";
    };
  };

  tezos-event-logging = buildDunePackage {
    pname = "tezos-event-logging";
    inherit (tezos-stdlib) version src useDune2 preBuild;

    propagatedBuildInputs = [
      tezos-lwt-result-stdlib
      lwt_log
    ];

    meta = tezos-stdlib.meta // {
      description = "Tezos: event logging library";
    };
  };

  tezos-lwt-result-stdlib = buildDunePackage {
    pname = "tezos-lwt-result-stdlib";
    inherit (tezos-stdlib) version src useDune2 preBuild;

    #maximumOCamlVersion

    propagatedBuildInputs = [
      tezos-error-monad
    ];

    meta = tezos-stdlib.meta // {
      description = "Tezos: error-aware stdlib replacement";
    };
  };

  tezos-micheline = buildDunePackage {
    pname = "tezos-micheline";
    inherit (tezos-stdlib) version src useDune2 preBuild;

    propagatedBuildInputs = [
      tezos-error-monad
      uutf
    ];

    meta = tezos-stdlib.meta // {
      description = "Tezos: internal AST and parser for the Michelson language";
    };
  };

  tezos-p2p-services = buildDunePackage {
    pname = "tezos-p2p-services";
    inherit (tezos-stdlib) version src useDune2 preBuild;

    propagatedBuildInputs = [
      tezos-base
    ];

    meta = tezos-stdlib.meta // {
      description = "Tezos: descriptions of RPCs exported by `tezos-p2p`";
    };
  };

  tezos-protocol-008-PtEdo2Zk-parameters = buildDunePackage {
    pname = "tezos-protocol-008-PtEdo2Zk-parameters";
    inherit (tezos-stdlib) version src useDune2 preBuild;

    propagatedBuildInputs = [
      tezos-protocol-008-PtEdo2Zk
    ];

    meta = tezos-stdlib.meta // {
      description = "Tezos/Protocol: parameters";
    };
  }
  ;

  tezos-protocol-008-PtEdo2Zk = buildDunePackage {
    pname = "tezos-protocol-008-PtEdo2Zk";
    inherit (tezos-stdlib) version src useDune2 doCheck;

    preBuild = ''
      rm -rf vendors
      sed -i.back -e s/-nostdlib//g src/proto_008_PtEdo2Zk/lib_protocol/dune.inc
    '';

    propagatedBuildInputs = [
      tezos-base
      tezos-protocol-environment
    ];

    buildInputs = [
      tezos-protocol-compiler
    ];

    meta = tezos-stdlib.meta // {
      description = "Tezos/Protocol: economic-protocol definition";
    };
  };

  tezos-protocol-compiler = buildDunePackage {
    pname = "tezos-protocol-compiler";
    inherit (tezos-stdlib) version src useDune2 preBuild;

    minimalOCamlVersion = "4.09";

    propagatedBuildInputs = [
      tezos-protocol-environment
      ocp-ocamlres
      pprint
    ];

    meta = tezos-stdlib.meta // {
      description = "Tezos: economic-protocol compiler";
    };
  };

  tezos-protocol-environment-packer = buildDunePackage {
    pname = "tezos-protocol-environment-packer";
    inherit (tezos-stdlib) version src useDune2 preBuild;

    minimalOCamlVersion = "4.03";

    meta = tezos-stdlib.meta // {
      description = "Tezos: sigs/structs packer for economic protocol environment";
    };
  };

  tezos-protocol-environment-sigs = buildDunePackage {
    pname = "tezos-protocol-environment-sigs";
    inherit (tezos-stdlib) version src useDune2 preBuild;

    propagatedBuildInputs = [
      tezos-protocol-environment-packer
    ];

    postPatch = ''
      cp -f ${zarith}/lib/ocaml/${ocaml.version}/site-lib/zarith/z.mli ./src/lib_protocol_environment/sigs/v1/z.mli
      sed -i 's/out_channel/Stdlib.out_channel/g' ./src/lib_protocol_environment/sigs/v1/z.mli
      sed -i 's/Buffer/Stdlib.Buffer/g' ./src/lib_protocol_environment/sigs/v1/z.mli
    '';

    meta = tezos-stdlib.meta // {
      description = "Tezos: restricted typing environment for the economic protocols";
    };
  };

  tezos-protocol-environment-structs = buildDunePackage {
    pname = "tezos-protocol-environment-structs";
    inherit (tezos-stdlib) version src useDune2 preBuild;

    propagatedBuildInputs = [
      tezos-crypto
      tezos-protocol-environment-packer
    ];

    meta = tezos-stdlib.meta // {
      description = "Tezos: restricted typing environment for the economic protocols";
    };
  };

  tezos-protocol-environment = buildDunePackage {
    pname = "tezos-protocol-environment";
    inherit (tezos-stdlib) version src useDune2 doCheck preBuild;

    propagatedBuildInputs = [
      tezos-sapling
      tezos-base
      tezos-protocol-environment-sigs
      tezos-protocol-environment-structs
      zarith # this might break, since they actually want 1.11
    ];

    meta = tezos-stdlib.meta // {
      description = "Tezos: custom economic-protocols environment implementation for `tezos-client` and testing";
    };
  };

  tezos-rpc = buildDunePackage {
    pname = "tezos-rpc";
    inherit (tezos-stdlib) version src useDune2 preBuild;

    propagatedBuildInputs = [
      tezos-error-monad
      resto
      resto-directory
    ];

    meta = tezos-stdlib.meta // {
      description = "Tezos: library of auto-documented RPCs (service and hierarchy descriptions)";
    };
  };

  tezos-sapling = buildDunePackage {
    pname = "tezos-sapling";
    inherit (tezos-stdlib) version src useDune2 preBuild;

    propagatedBuildInputs = [
      tezos-crypto
      tezos-rust-libs
    ];

    doCheck = false;

    # This is a hack to work around the hack used in the dune files
    OPAM_SWITCH_PREFIX = "${tezos-rust-libs}";

    meta = tezos-stdlib.meta // {
      description = "Tezos/Protocol: economic-protocol definition";
    };
  };

  tezos-stdlib-unix = buildDunePackage {
    pname = "tezos-stdlib-unix";
    inherit (tezos-stdlib) version src useDune2 preBuild;

    propagatedBuildInputs = [
      tezos-event-logging
      lwt
      ptime
      mtime
      ipaddr
      re
    ];

    meta = tezos-stdlib.meta // {
      description = "Tezos: yet-another local-extension of the OCaml standard library (unix-specific fragment)";
    };
  };

  tezos-stdlib = buildDunePackage rec {
    pname = "tezos-stdlib";
    version = "8.3";
    src = builtins.fetchurl {
      url = "https://gitlab.com/tezos/tezos/-/archive/v${version}/tezos-v${version}.tar.bz2";
      sha256 = "17ca44fz5qx2l2w45fa5xkriwl95rzqai9l6rr16bllvr8j8dy8k";
    };

    minimalOCamlVersion = "4.0.8";

    useDune2 = true;

    preBuild = ''
      rm -rf vendors
    '';

    propagatedBuildInputs = [
      hex
      lwt
      zarith
    ];

    doCheck = false;

    meta = {
      description = "Tezos: yet-another local-extension of the OCaml standard library";
      license = lib.licenses.mit;
      maintainers = [ lib.maintainers.ulrikstrid ];
    };
  };

  tezos-version = buildDunePackage {
    pname = "tezos-version";
    inherit (tezos-stdlib) version src useDune2 preBuild;

    propagatedBuildInputs = [
      tezos-base
    ];

    meta = tezos-stdlib.meta // {
      description = "Tezos: version information generated from Git";
    };
  };

  tezos-workers = buildDunePackage {
    pname = "tezos-workers";
    inherit (tezos-stdlib) version src useDune2 preBuild;

    propagatedBuildInputs = [
      tezos-base
    ];

    meta = tezos-stdlib.meta // {
      description = "Tezos: worker library";
    };
  };

  tezos-rust-libs = pkgs.rustPlatform.buildRustPackage rec {
    pname = "tezos-rust-libs";
    version = "1.0";

    src = builtins.fetchurl {
      url = "https://gitlab.com/tezos/tezos-rust-libs/-/archive/v${version}/tezos-rust-libs-v${version}.tar.bz2";
      sha256 = "1gfp62qvjcwgr3377vkdi6x9drpis2mz74ypx1bzsnxbm1jizj7j";
    };

    cargoSha256 = "0dgyqfr3dvvdwdi1wvpd7v9j21740jy4zwrwiwknw7csb4bq9wfx";

    preBuild = ''
      mkdir .cargo
      mv cargo-config .cargo/config
    '';

    postInstall = ''
      cp -r rustc-bls12-381/include $out/include
      cp -r librustzcash/include $out
      cp -r $out/lib $out/tmp
      mkdir $out/lib/tezos-rust-libs
      mv $out/tmp/ $out/lib/tezos-rust-libs/
    '';

    doCheck = false;

    meta = {
      homepage = "https://gitlab.com/tezos/tezos-rust-libs";
      description = "Tezos: all rust dependencies and their dependencies";
      license = lib.licenses.mit;
      maintainers = [ lib.maintainers.ulrikstrid ];
    };
  };

  hacl-star-raw = stdenv.mkDerivation rec {
    pname = "ocaml${ocaml.version}-hacl-star-raw";
    version = "0.3.2";

    src = fetchzip {
      url = "https://github.com/project-everest/hacl-star/releases/download/ocaml-v${version}/hacl-star.${version}.tar.gz";
      sha256 = "1wp27vf0g43ggs7cv85hpa62jjvzkwzzg5rfznbwac6j6yr17zc7";
      stripRoot = false;
    };

    sourceRoot = "./source/raw";

    minimalOCamlVersion = "4.05";

    postPatch = ''
      patchShebangs ./
    '';

    preInstall = ''
      mkdir -p $OCAMLFIND_DESTDIR/stublibs
    '';

    installTargets = "install-hacl-star-raw";

    dontAddPrefix = true;

    buildInputs = [
      pkgs.which
      ocaml
      findlib
    ];

    propagatedBuildInputs = [
      ctypes
    ];

    checkInputs = [
      cppo
    ];

    doCheck = false;

    meta = {
      description = "Auto-generated low-level OCaml bindings for EverCrypt/HACL*";
      license = lib.licenses.asl20;
      maintainers = [ lib.maintainers.ulrikstrid ];
      platforms = ocaml.meta.platforms;
    };
  };

  hacl-star = buildDunePackage {
    pname = "hacl-star";

    inherit (hacl-star-raw) version src meta doCheck minimalOCamlVersion;

    useDune2 = true;

    propagatedBuildInputs = [
      hacl-star-raw
      zarith
    ];

    buildInputs = [
      cppo
    ];
  };

  ringo = buildDunePackage rec {
    pname = "ringo";
    version = "0.5";

    src = builtins.fetchurl {
      url = "https://gitlab.com/nomadic-labs/ringo/-/archive/v${version}/ringo-v${version}.tar.bz2";
      sha256 = "14lkp5m2xnnk1gy3drq9h75z2z37w8npfg16z6ifg0i94m38fw3y";
    };

    minimalOCamlVersion = "4.05";

    useDune2 = true;

    doCheck = false;

    # If we just run the test as is it will try to test ringo-lwt
    checkPhase = "dune build @test/runtest";

    meta = {
      description = "Caches (bounded-size key-value stores) and other bounded-size stores";
      license = lib.licenses.mit;
      maintainers = [ lib.maintainers.ulrikstrid ];
    };
  };

  ringo-lwt = buildDunePackage {
    pname = "ringo-lwt";
    inherit (ringo) version src doCheck useDune2;

    minimalOCamlVersion = "4.08";

    propagatedBuildInputs = [
      ringo
      lwt
    ];

    meta = ringo.meta // {
      description = "Lwt-wrappers for Ringo caches";
    };
  };
}

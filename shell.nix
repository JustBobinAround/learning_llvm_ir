{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.clang_16
  ];

  #uncomment for release testing:
  #PURE_ENV = true;
}


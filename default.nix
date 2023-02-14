let
  pkgs = import <nixpkgs> { };
in
pkgs.mkShell {
  buildInputs = [
    pkgs.elixir_1_14
    pkgs.erlangR25
  ];
}

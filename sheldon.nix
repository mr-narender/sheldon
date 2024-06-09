# Sheldon package definition
#
# This file will be similar to the package definition in nixpkgs:
#     https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/sh/sheldon/package.nix
#
# Helpful documentation: https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/rust.section.md
{
  pkgs,
  lib,
  stdenv,
  installShellFiles,
  rustPlatform,
  Security,
}:
rustPlatform.buildRustPackage {
  name = "sheldon";

  src = lib.cleanSource ./.;

  cargoLock = {
    lockFile = ./Cargo.lock;
    # Allow dependencies to be fetched from git and avoid having to set the outputHashes manually
    allowBuiltinFetchGit = true;
  };

  nativeBuildInputs = [installShellFiles];

  buildInputs = [ pkgs.openssl pkgs.curl ] ++ lib.optionals stdenv.isDarwin [Security];

  doCheck = false;

  meta = with lib; {
    description = "Fast, configurable, shell plugin manager";
    homepage = "https://github.com/rossmacarthur/sheldon";
    license = licenses.mit;
    mainProgram = "sheldon";
  };
}

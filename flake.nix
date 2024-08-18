{
  description = "Application packaged using poetry2nix";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    poetry2nix = {
      url = "github:bclaud/poetry2nix/litestar-deps";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, poetry2nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        # see https://github.com/nix-community/poetry2nix/tree/master#api for more functions and examples.
        pkgs = nixpkgs.legacyPackages.${system};
        inherit (poetry2nix.lib.mkPoetry2Nix { inherit pkgs; }) mkPoetryApplication mkPoetryEnv;
      in
      {
        packages = rec {
          demoError = mkPoetryApplication { projectDir = ./.; checkGroups = [ ]; };
          devDemoError = mkPoetryEnv {
            projectDir = ./.;
            editablePackageSources = {
              app = ./demo_error;
            };
          };
          default = self.packages.${system}.demoError;
          polyfactory = pkgs.callPackage ./polyfactory.nix { };
          litestar = pkgs.callPackage ./litestar-dep.nix { polyfactory = polyfactory; };
          demoErrorBuildPythonApp = pkgs.callPackage ./default.nix { litestar = litestar; };
        };

        # Shell for app dependencies.
        #
        #     nix develop
        #
        # Use this shell for developing your app.
        devShells.default = pkgs.mkShell {
          name = "dev-shell";
          buildInputs = [ ];
          packages = [ pkgs.watchexec pkgs.ruff pkgs.poetry self.packages.${system}.devDemoError ];
        };

        # Shell for poetry.
        #
        #     nix develop .#poetry
        #
        # Use this shell for changes to pyproject.toml and poetry.lock.
        devShells.poetry = pkgs.mkShell {
          packages = [ pkgs.poetry ];
        };

        formatter = pkgs.nixpkgs-fmt;
      });
}

{
  description = "Testing with Simple GitHub Actions";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, flake-utils, poetry2nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs-unstable.legacyPackages.${system};

        basePackages = with pkgs; [
          act
          gh
          neofetch
        ];

        customOverrides = self: super: {
          # Overrides go here
        };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = basePackages;
        };
      }
    );
}

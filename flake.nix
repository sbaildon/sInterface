{
  description = "sInterface — An opinionated replacement for Blizzard's UI";

  # go here for using all system
  # https://serokell.io/blog/practical-nix-flakes

  inputs = {
    nixpkgs.url =
      "github:NixOS/nixpkgs/819e4d63fc7f337a822a049fd055cd7615a5e0d6";
  };

  outputs = { self, nixpkgs }:
    let pkgs = nixpkgs.legacyPackages.x86_64-darwin;
    in {
      formatter.x86_64-darwin = pkgs.nixfmt;

      # nix develop
      devShells.x86_64-darwin.default =
        pkgs.mkShell { buildInputs = [ pkgs.fennel ]; };

      apps.x86_64-darwin.fennel = {
        type = "app";
        program = "${pkgs.fennel}/bin/fennel";
      };
    };
}

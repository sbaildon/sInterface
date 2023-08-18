{
  description = "sInterface";

  outputs = { self, nixpkgs }:
    let pkgs = nixpkgs.legacyPackages.aarch64-darwin;
    in
    {
      formatter.aarch64-darwin = pkgs.nixfmt;

      devShells.aarch64-darwin.default = pkgs.mkShell {
        buildInputs = [
          pkgs.fennel
          pkgs.fnlfmt
        ];
      };

      apps.aarch64-darwin.fennel = {
        type = "app";
        program = "${pkgs.fennel}/bin/fennel";
      };

      apps.aarch64-darwin.fnlfmt = {
        type = "app";
        program = "${pkgs.fennelfmt}/bin/fnlfmt";
      };
    };
}

{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };
  outputs = { self, nixpkgs }:
  let pkgs = nixpkgs.legacyPackages.x86_64-linux.haskellPackages;
  in {
    packages.x86_64-linux = {
      default = pkgs.callCabal2nix "advent-of-code" ./. {};
    };
    apps.x86_64-linux = {
      default = {
        type = "app";
        program = "${self.packages.x86_64-linux.default}/bin/advent-of-code";
      };
    };
    devShell.x86_64-linux = pkgs.shellFor {
      packages = p: [ self.packages.x86_64-linux.default ];
      withHoogle = true;
      buildInputs = with pkgs; [
        haskell-language-server
        ghcid
        cabal-install
      ];
    };
  };
}

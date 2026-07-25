{
  description = "Nautilus extension to open files and folders in Zed";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs, ... }:
    let
      eachSystem =
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
          package = pkgs.callPackage ./nixos/package.nix {
            src = self;
          };
        in
        {
          packages = {
            default = package;
            ${package.pname} = package;
          };
        };
    in
    {
      packages.x86_64-linux = (eachSystem "x86_64-linux").packages;
      packages.aarch64-linux = (eachSystem "aarch64-linux").packages;
    };
}

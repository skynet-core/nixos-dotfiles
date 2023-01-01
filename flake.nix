{
  description = "Skynet's Awesome System Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@attrs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };
    lib = nixpkgs.lib;
    overlay-unstable = final: prev: {
        # unstable = nixpkgs-unstable.legacyPackages.${prev.system};
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
    alacrittyConfig = import ./users/vasyl/alacritty.nix {};
  in {
    homeManagerConfigurations = {
      vasyl = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          (import ./users/vasyl/home.nix { 
            inherit attrs; 
            pkgs = pkgs;
            nixpkgs-unstable = nixpkgs-unstable;
            alacrittyConfig = alacrittyConfig;
          })
        ];
      };
    };
    nixosConfigurations = {
      flowx13 = lib.nixosSystem {
        inherit system;
        specialArgs = attrs;
        modules = [
          ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
          ./system/configuration.nix
        ];
      };
    };
  };
}

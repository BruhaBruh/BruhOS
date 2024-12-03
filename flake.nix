{
  description = "BruhaBruh NixOS dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
    hyprland.url = "github:hyprwm/Hyprland";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    apple-fonts = {
      url = "github:Lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    apple-emoji = {
      url = "github:oxcl/apple-emoji-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, stylix, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";

      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-stable = nixpkgs-stable.legacyPackages.${system};

      vars = import ./variables.nix;
      aliases = import ./aliases.nix;

      scripts = import ./scripts {
        inherit lib system pkgs pkgs-stable vars aliases inputs;
      };
    in
    {
      nixosConfigurations.${ vars.hostName} = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit pkgs-stable vars aliases inputs system scripts;
        };
        modules = [
          stylix.nixosModules.stylix
          ./system
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit pkgs-stable vars aliases inputs system scripts;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.${vars.username} = import ./home;
          }
        ];
      };
    };
}

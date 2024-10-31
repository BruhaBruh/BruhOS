{
  description = "BruhaBruh NixOS dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... }@inputs: 
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";

    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-stable = nixpkgs-stable.legacyPackages.${system};

    vars = {
      flakeDirectory = "/home/bruhabruh/.dotfiles";
      hostName = "desktop";
      username = "bruhabruh";

      timeZone = "Asia/Yekaterinburg";

      locale = {
        default = "en_US.UTF-8";
        extra = "ru_RU.UTF-8";
        supported = [
          "en_US.UTF-8/UTF-8"
          "ru_RU.UTF-8/UTF-8"
        ];
      };

      git = {
        username = "BruhaBruh";
        email = "drugsho.jaker@gmail.com";
        defaultBranch = "main";
      };
    };
  in {
    nixosConfigurations.${vars.hostName} = lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit pkgs-stable vars inputs system;
      };
      modules = [
        ./system
        home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = {
            inherit pkgs-stable vars inputs system;
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

{
  description = "NixOS dots";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";

      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-stable = nixpkgs-stable.legacyPackages.${system};

      vars = {
        flakeDirectory = "$HOME/nixos-dots";
        hostName = "nixos";
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
    in
    {
      nixosConfigurations = {
        "${vars.hostName}" = lib.nixosSystem {
          specialArgs = {
	          inherit system;
            inherit inputs;
            inherit vars;
          };
          modules = [
            ./hosts/${vars.hostName}/configuration.nix
            inputs.stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit vars;
                inherit inputs;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.${vars.username} = import ./hosts/${vars.hostName}/home.nix;
            }
          ];
        };
      };
    };
}

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
    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... }@inputs: 
    let 
      system = "x86_64-linux";

      flakeDirectory = "$HOME/.dotfiles";

      host = "nixos";
      username = "bruhabruh";

      gitUsername = "BruhaBruh";
      gitEmail = "drugsho.jaker@gmail.com";

      extraMonitorSettings = "";

      clock24h = true;

      browser = "firefox";
      terminal = "foot";
      keyboardLayout = "us";
    in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        ./nixos/configuration.nix
        inputs.distro-grub-themes.nixosModules.${system}.default
      ];
      specialArgs = {
        inherit inputs system flakeDirectory host username gitUsername gitEmail extraMonitorSettings clock24h browser terminal keyboardLayout;
        pkgs = import nixpkgs {
          inherit system inputs;
          config.allowUnfree = true;
        };
        pkgs-stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
      };
    };

    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [ ./home-manager ];
    };
  };
}


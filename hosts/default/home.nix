{
  pkgs,
  vars,
  ...
}:

{
  # Home Manager Settings
  home.username = "${vars.username}";
  home.homeDirectory = "/home/${vars.username}";
  home.stateVersion = "24.05";

  # Import Program Configurations
  imports = [
  ];

  # Place Files Inside Home Directory

  # Install & Configure Git
  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "${vars.git.defaultBranch}";
      user.name = "${vars.git.username}";
      user.email = "${vars.git.email}";
    };
  };

  home.packages = with pkgs; [
    zsh
    fzf
  ];

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "history" "sudo" ];
        theme = "agnoster";
      };
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        rebuild = "sudo nixos-rebuild switch --flake ${vars.flakeDirectory}";
        rebuildHome = "home-manager switch --flake ${vars.flakeDirectory}";
        rebuildAll = "sudo nixos-rebuild switch --flake ${vars.flakeDirectory} && home-manager switch --flake ${vars.flakeDirectory}";
        sshtimeweb = "ssh root@46.19.67.148";
        sshpostnow = "ssh root@83.147.244.71";
        sshaeza = "ssh root@91.184.242.152";
        aezatunnel = "ssh -N -L 2053:localhost:2053 root@91.184.242.152";
        cat = "bat";
        ls = "eza --icons=always";
      };
    };
  };
}

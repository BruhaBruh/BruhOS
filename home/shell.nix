{ vars, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    # ohMyZsh = {
    #   enable = true;
    #   plugins = [ "git" "history" "sudo" ];
    #   theme = "agnoster";
    # };
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      "rebuild" = "sudo nixos-rebuild switch --flake ${vars.flakeDirectory}";
      "rebuildHome" = "home-manager switch --flake ${vars.flakeDirectory}";
      "rebuildAll" = "sudo nixos-rebuild switch --flake ${vars.flakeDirectory} && home-manager switch --flake ${vars.flakeDirectory}";
    };
  };
}

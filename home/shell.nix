{ vars, aliases, scripts, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "history" "sudo" ];
      theme = "agnoster";
    };
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtra = ''
      PROMPT="%F{green}%~%f %F{blue}%f "
      RPROMPT="%F{7}%?%f - %F{7}%T%f"
    '';
    shellAliases = {
      sudo = "${scripts.ssudo}/bin/ssudo";
      fullClean = '' 
        nix-collect-garbage --delete-old

        sudo nix-collect-garbage -d

        sudo /run/current-system/bin/switch-to-configuration boot
      '';
      rebuild = "sudo nixos-rebuild switch --flake ${vars.flakeDirectory}";
      cat = "bat";
      ls = "eza --icons=always";
    } // aliases;
  };
}

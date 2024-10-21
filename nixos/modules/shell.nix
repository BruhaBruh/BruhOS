{ pkgs, ... }: {
  environment.shells = with pkgs; [ zsh ];
  
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      ohMyZsh = {
        enable = true;
        plugins = [ "git" "sudo" ];
        theme = "agnoster";
      };
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      promptInit = ''
      # fastfetch -c $HOME/.config/fastfetch/config-compat.jsonc

      source <(fzf --zsh);
      HISTFILE=$HOME/.zsh_history;
      HISTSIZE=10000;
      SAVEHIST=10000;
      setopt appendHistory;
      '';
    };
  };
}

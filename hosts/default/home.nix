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

  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [ fzf ]; 
    
  programs = {
  # Zsh configuration
	  zsh = {
    	enable = true;
	  	enableCompletion = true;
      ohMyZsh = {
        enable = true;
        plugins = ["git"];
        theme = "xiong-chiamiov-plus"; 
      	};
      
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      
      promptInit = ''
        source <(fzf --zsh);
        HISTFILE=~/.zsh_history;
        HISTSIZE=10000;
        SAVEHIST=10000;
        setopt appendhistory;
        '';
      };
   };
}

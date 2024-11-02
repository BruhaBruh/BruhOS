{ vars, ... }:

{
  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "${vars.git.defaultBranch}";
      user.name = "${vars.git.username}";
      user.email = "${vars.git.email}";
    };
  };
}

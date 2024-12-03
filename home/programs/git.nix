{ vars, ... }:

{
  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "${vars.git.defaultBranch}";
      user.name = "${vars.git.username}";
      user.email = "${vars.git.email}";
      alias = {
        st = "status -s";
        sta = "status";
        config = "config --global --edit";
        ci = "commit";
        ciam = "commit -a --amend --no-edit";
        co = "checkout";
        cod = "checkout .";
        rh = "reset HEAD";
        aa = "add -A";
        cdf = "clean -df";
        br = "branch";
        bra = "branch -a";
        pr = "pull --rebase";
      };
    };
  };
}

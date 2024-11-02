{ pkgs, vars, ... }:

{
  users = {
    defaultUserShell = pkgs.zsh;
    mutableUsers = true;

    users.${vars.username} = {
      isNormalUser = true;
      description = "${vars.git.username}";
      homeMode = "755";
      extraGroups = [
        "wheel"
        "networkmanager"
        "input"
        "libvirtd"
        "video"
        "audio"
      ];
      packages = with pkgs; [ ];
    };
  };
}

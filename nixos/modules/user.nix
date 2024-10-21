{ pkgs, username, gitUsername, ... }: {
  users.users.${username} = {
    homeMode = "755";
    isNormalUser = true;
    description = gitUsername;
    extraGroups = [
      "wheel"
      "input"
      "networkmanager"
      "libvirtd"
      "lp"
      "video"
      "audio"
    ];
    packages = with pkgs; [];
  };
  users.defaultUserShell = pkgs.zsh;
}


{
  pkgs,
  vars,
  ...
}:

{
  users = {
    mutableUsers = true;

    users."${vars.username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "${vars.git.username}";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
        "video" 
        "input" 
        "audio"
      ];
      shell = pkgs.zsh;
      ignoreShellProgramCheck = true;
      packages = with pkgs; [
      ];
    };
  };
}

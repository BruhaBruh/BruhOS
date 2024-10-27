{
  pkgs,
  vars,
  ...
}:

{
  users.users = {
    "${vars.username}" = {
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
      shell = pkgs.bash;
      ignoreShellProgramCheck = true;
      packages = with pkgs; [
      ];
    };
  };
}

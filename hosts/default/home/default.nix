{
  pkgs,
  vars,
  ...
}:

{
  imports = [
    ./modules
  ];

  home.username = "${vars.username}";
  home.homeDirectory = "/home/${vars.username}";
  home.stateVersion = "24.05";
}

{ vars, lib, ... }:

{
  networking.hostName = "${vars.hostName}";
  networking.networkmanager.enable = true;
}

{ vars, lib, ... }:

{
  networking.hostName = "${vars.hostName}";
  networking.networkmanager.enable = true;
  networking.proxy = lib.mkIf vars.proxy.enabled {
    allProxy = "http://127.0.0.1:2081";
    noProxy = "127.0.0.1,localhost";
  };
}

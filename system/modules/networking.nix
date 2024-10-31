{ vars, ... }:

{
  networking.hostName = "${vars.hostName}";
  networking.networkmanager.enable = true;
  # Uncomment after configure nekoray profile
  networking.proxy = {
    allProxy = "http://127.0.0.1:2081";
    noProxy = "127.0.0.1,localhost";
  };
}

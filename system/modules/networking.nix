{ vars, lib, ... }:

{
  networking.hostName = "${vars.hostName}";
  networking.networkmanager.enable = true;
  # networking.useHostResolvConf = true;
  # networking.proxy = {
  #   httpProxy = "http://127.0.0.1:2081";
  #   httpsProxy = "http://127.0.0.1:2081";
  #   noProxy = "*.test.example.com,.example.org,127.0.0.0/8,localhost,.localdomain";
  # };
}

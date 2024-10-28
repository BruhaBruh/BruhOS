{ vars, options, ... }:

{
  networking.networkmanager.enable = true;
  networking.hostName = "${vars.hostName}";
  networking.timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
}
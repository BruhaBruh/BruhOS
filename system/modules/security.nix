{ pkgs, ... }:

{
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';

  security.wrappers = {
    nekobox_core = {
      owner = "root";
      group = "root";
      source = "${pkgs.nekoray.nekobox-core}/bin/nekobox_core";
      capabilities = "cap_net_admin=ep";
    };
  };
}

{ vars, ... }:

{
  i18n.defaultLocale = "${vars.locale.default}";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "${vars.locale.extra}";
    LC_IDENTIFICATION = "${vars.locale.extra}";
    LC_MEASUREMENT = "${vars.locale.extra}";
    LC_MONETARY = "${vars.locale.extra}";
    LC_NAME = "${vars.locale.extra}";
    LC_NUMERIC = "${vars.locale.extra}";
    LC_PAPER = "${vars.locale.extra}";
    LC_TELEPHONE = "${vars.locale.extra}";
    LC_TIME = "${vars.locale.extra}";
  };

  i18n.supportedLocales = vars.locale.supported;
}
{ lib, appimageTools, fetchurl, ... }:

let
  version = "1.1.2";
  pname = "reyohoho";
  src = fetchurl {
    url = "https://github.com/reyohoho/reyohoho-desktop/releases/download/${version}/ReYohoho.Setup.${version}_x86_64.AppImage";
    hash = "sha256-ORkBpvEL/Ksxw2A7A8QNANl/tLdyz/0wn9+0IR9FgBc=";
  };

  appimageContents = appimageTools.extractType2 { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;
  extraInstallCommands = ''
        install -m 444 -D ${appimageContents}/reyohoho.desktop $out/share/applications/${pname}.desktop || echo "Desktop file not found at expected location"

        if [ -f "$out/share/applications/${pname}.desktop" ]; then
          substituteInPlace $out/share/applications/${pname}.desktop \
          --replace-fail 'Exec=AppRun' 'Exec=${pname}'
        else
          # Create a basic desktop file if one wasn't found
          mkdir -p $out/share/applications
          cat > $out/share/applications/${pname}.desktop << EOF
    [Desktop Entry]
    Name=ReYohoho
    Exec=${pname}
    Type=Application
    Categories=Utility;
    EOF
        fi

        mkdir -p $out/share/icons/hicolor/256x256/apps
        if ls ${appimageContents}/usr/share/icons/hicolor/256x256/apps/*.png &>/dev/null; then
          cp ${appimageContents}/usr/share/icons/hicolor/256x256/apps/*.png $out/share/icons/hicolor/256x256/apps/${pname}.png
        fi
  '';
  meta = with lib; {
    description = "Reyohoho desktop application";
    homepage = "https://github.com/reyohoho/reyohoho-desktop";
    downloadPage = "https://github.com/reyohoho/reyohoho-desktop/releases";
    license = licenses.cc0;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    mainProgram = pname;
    maintainers = with maintainers; [ onny ];
    platforms = [ "x86_64-linux" ];
  };
}

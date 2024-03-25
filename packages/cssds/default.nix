{
  fetchSteam,
  stdenvNoCC,
  SDL2,
  ncurses5,
  libgcc,
  lib,
  autoPatchelfHook,
  makeWrapper,
}:
stdenvNoCC.mkDerivation rec {
  name = "cssds";
  version = "public";

  src = fetchSteam {
    inherit name;
    appId = "232330";
    depotId = "232336";
    manifestId = "2107924716899862244";
    hash = "sha256-bDhJRKKJaS7k6SqpZ9rJV3zoVjHqQIEeDfIwFAuVCUk=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
  ];
  buildInputs = [ libgcc.lib ];

  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share
    cp -r cstrike $out/share/cstrike
    cp -r bin $out/lib
    cp -r cstrike/bin/server_srv.so $out/lib
    rm $out/lib/libstdc++.so.6
    install -Dm555 -t $out/bin srcds_*
    echo "232330" > $out/steam_appid.txt

    runHook postInstall
  '';

  postFixup = ''
    wrapProgram $out/bin/srcds_linux \
      --prefix LD_LIBRARY_PATH : ${
        lib.makeLibraryPath [
          ncurses5
          libgcc
          SDL2
        ]
      }:$out/lib
  '';

  meta = with lib; {
    description = "CS:S dedicated server";
    homepage = "https://steamdb.info/app/232330/";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    license = licenses.unfree;
    platforms = [ "i686-linux" ];
    mainProgram = "srcds_linux";
  };
}

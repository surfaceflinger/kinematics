{
  cssds,
  lib,
  cssds-assets,
  stdenvNoCC,
  makeWrapper,
  sourcemod-css,
  metamod-css,
  symlinkJoin,
}:
let
  addons = symlinkJoin {
    name = "plugins";
    paths = [
      metamod-css
      sourcemod-css
    ];
  };
in
stdenvNoCC.mkDerivation rec {
  pname = "kinematics";
  version = "public";

  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/{share/kinematics,bin}
    for i in ${cssds-assets}/{cstrike,hl2}; do
      mkdir -p $out/share/kinematics/$(basename $i)
      ln -s $i/* $out/share/kinematics/$(basename $i)/
    done

    mkdir -p $out/share/kinematics/cstrike/addons
    ln -s ${addons}/share/addons/* $out/share/kinematics/cstrike/addons/

    ln -s ${lib.getExe cssds} $out/share/kinematics/
    echo -e 'exec '$out'/share/kinematics/srcds_linux -game '$out'/share/kinematics/cstrike "$@"' >> $out/bin/kinematics
    chmod +x $out/bin/kinematics

    runHook postInstall
  '';
}

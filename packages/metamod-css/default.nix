{
  clangStdenv,
  fetchFromGitHub,
  hl2sdk-css,
  ambuild,
}:

clangStdenv.mkDerivation {
  pname = "metamod-css";
  version = "0-unstable-2024-03-07";

  src = fetchFromGitHub {
    owner = "alliedmodders";
    repo = "metamod-source";
    rev = "9fbe7f37ab96f06fad73b92446f2d738a1b64ac7";
    hash = "sha256-cljnSEVOlHQHySVAdQ+z6tNWMvJMlhgyxRxjdt6Fb78=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ ambuild ];

  buildPhase = ''
    ln -s ${hl2sdk-css} hl2sdk-css
    mkdir build
    cd build
    python ../configure.py --sdks css --enable-optimize --disable-auto-versioning
    ambuild
  '';

  installPhase = ''
    mkdir -p $out
    mv package $out/share
    cp -r $src $out/include
  '';
}
